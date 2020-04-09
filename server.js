// node moduli
const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const swaggerJsDoc = require('swagger-jsdoc');
const swaggerUi = require('swagger-ui-express');
const neo4j = require('neo4j-driver')
const MongoClient = require('mongodb').MongoClient;
const url = 'mongodb://localhost:27017';
const dbName = 'projekat';

let mongoDB = null;
MongoClient.connect(url, { useUnifiedTopology: true }, function(err, client) {
    mongoDB = client.db(dbName);
});

// parsiranje podataka iz forme
app.use(bodyParser.urlencoded({ extended: true }));

// template parsing preko ejs-a
app.set('view engine', 'ejs');

// importovanje js i css fajlova za koriscenje u aplikaciji
app.use('/js', express.static(__dirname + '/node_modules/bootstrap/dist/js'));
app.use('/js', express.static(__dirname + '/node_modules/tether/dist/js'));
app.use('/js', express.static(__dirname + '/node_modules/jquery/dist'));
app.use('/css', express.static(__dirname + '/node_modules/bootstrap/dist/css'));
app.use('/css', express.static(__dirname + '/public/css'));
app.use('/images', express.static(__dirname + '/public/images'));

// globalni naziv sajta i globalni url
const siteTitle = "Project";

const swaggerOptions = {
    swaggerDefinition: {
        info: {
            title: 'RuInf',
            description: 'Rukovalac informacionim resursima',
            servers: ["http://localhost:4000"]
        }
    },
    apis: ["server.js"]
};

const swaggerDocs = swaggerJsDoc(swaggerOptions);
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocs));

var MySql = require('sync-mysql');

var connection = new MySql({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'projekat'
});

// Neo4j konekcija:
const neo4jConnection = neo4j.driver('neo4j://localhost', neo4j.auth.basic('neo4j', 'neo4j'));

// main
app.get('/', function (req, res) {
    res.render('pages/index', {
        siteTitle: siteTitle,pageTitle: "Home Page"
    });
});

                                            // TABELA KATEGORIJE //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// get edit za ulazak u formu KATEGORIJE
/**
 * @swagger
 * /kategorije/edit:
 *  get:
 *    description: Pristupa edit formi za KATEGORIJE
 *    responses:
 *      '200':
 *          description: Uspesno otvorena forma
 */
app.get('/kategorije/edit/:polje/:grupa/:oblast/:kategorija', function (req, res) {
    let result = connection.query(`
    SELECT
        *
    FROM
        kategorija_kompetencije
    WHERE
        PO_POLJE = ? AND
        GRU_GRUPA = ? AND
        OBL_OBLAST = ? AND
        KOMP_KATEGORIJA = ?`, [req.params.polje, req.params.grupa, req.params.oblast, req.params.kategorija]);

    res.render('pages/edit-kategorije', {
        siteTitle: 'Izmena',
        pageTitle: "Izmena : " + result[0].KOMP_NAZIV,
        item: result[0]
    });
});

// post edit, za izvrsavanje izmenjenog sadrzaja KATEGORIJE
/**
 * @swagger
 * /kategorije/edit:
 *  post:
 *    description: Menjanje sadrzaja tabele KATEGORIJE
 *    responses:
 *      '200':
 *          description: Uspesno izmenjeni podaci u tabeli
 */
app.post('/kategorije/edit/:polje/:grupa/:oblast/:kategorija', function (req, res) {
    connection.query(`
    UPDATE kategorija_kompetencije SET 
        KOMP_NAZIV = ?,
        KOMP_OPIS = ?
    WHERE
        PO_POLJE = ? AND
        GRU_GRUPA = ? AND
        OBL_OBLAST = ? AND
        KOMP_KATEGORIJA = ?`,
        [
            req.body.KOMP_NAZIV, // Edit:
            req.body.KOMP_OPIS,
            req.params.polje, // Find
            req.params.grupa,
            req.params.oblast,
            req.params.kategorija
        ]
    );

    neo4jConnection.session().run('MATCH (k:Kategorija { kategorija_id: $id }) SET k.naziv = $naziv, k.opis = $opis RETURN k', {
        id: req.params.kategorija,
        naziv: req.body.KOMP_NAZIV,
        opis: req.body.KOMP_OPIS
    });

    res.redirect('/kategorije');
});

// get add za ulazak u formu
/**
 * @swagger
 * /kategorije/add:
 *  get:
 *    description: Pristupa add formi za KATEGORIJE
 *    responses:
 *      '200':
 *          description: Uspesno otvorena forma
 */
app.get('/kategorije/add', function (req, res) {
    let pgoLista = connection.query(`SELECT
                                        DISTINCT(CONCAT(roo.PO_POLJE, "/", roo.GRU_GRUPA, "/", roo.OBL_OBLAST)) AS "key",
                                        CONCAT(rop.PO_NAZIV, " > ", gro.GRU_NAZIV, " > ", roo.OBL_NAZIV) AS "value"
                                    FROM
                                        registar_oblasti_obrazovanja AS roo
                                    INNER JOIN registar_obrazovnih_polja AS rop ON roo.PO_POLJE = rop.PO_POLJE
                                    INNER JOIN registar_grupa_obrazovanja AS gro ON roo.GRU_GRUPA = gro.GRU_GRUPA
                                    ORDER BY
                                        rop.PO_NAZIV,
                                        gro.GRU_NAZIV,
                                        roo.OBL_NAZIV;`);

    res.render('pages/add-kategorije', {
        siteTitle: 'Dodavanje',
        pageTitle: "Dodavanje nove kategorije",
        pgoLista: pgoLista,
        message: ''
    });
});

// post add, za dodavanje sadrzaja
/**
 * @swagger
 * /kategorije/add:
 *  post:
 *    description: Dodavanje sadrzaja u tabelu KATEGORIJE
 *    responses:
 *      '200':
 *          description: Uspesno prosledjeni podaci u tabelu
 */
app.post('/kategorije/add/', function (req, res) {
    let pgo = req.body.pgo;

    let delovi = pgo.split('/');

    let polje = delovi[0];
    let grupa = delovi[1];
    let oblast = delovi[2];

    try {
        connection.query(`
            INSERT kategorija_kompetencije SET 
                KOMP_NAZIV = ?,
                KOMP_OPIS = ?,
                PO_POLJE = ?,
                GRU_GRUPA = ?,
                OBL_OBLAST = ?,
                KOMP_KATEGORIJA = ?`,
            [
                req.body.KOMP_NAZIV, // Add:
                req.body.KOMP_OPIS,
                polje,
                grupa,
                oblast,
                req.body.KOMP_KATEGORIJA
            ]
        );

        neo4jConnection.session().run('CREATE (k:Kategorija { kategorija_id: $id, naziv: $naziv, opis: $opis })', {
            id: req.body.KOMP_KATEGORIJA,
            naziv: req.body.KOMP_NAZIV,
            opis: req.body.KOMP_OPIS
        });
    } catch (e) {
        let pgoLista = connection.query(`SELECT
                                        DISTINCT(CONCAT(roo.PO_POLJE, "/", roo.GRU_GRUPA, "/", roo.OBL_OBLAST)) AS "key",
                                        CONCAT(rop.PO_NAZIV, " > ", gro.GRU_NAZIV, " > ", roo.OBL_NAZIV) AS "value"
                                    FROM
                                        registar_oblasti_obrazovanja AS roo
                                    INNER JOIN registar_obrazovnih_polja AS rop ON roo.PO_POLJE = rop.PO_POLJE
                                    INNER JOIN registar_grupa_obrazovanja AS gro ON roo.GRU_GRUPA = gro.GRU_GRUPA
                                    ORDER BY
                                        rop.PO_NAZIV,
                                        gro.GRU_NAZIV,
                                        roo.OBL_NAZIV;`);

        let message = 'Doslo je do neke greske.';

        if (e.code === 'ER_DUP_ENTRY') {
            message = 'Nije moguce dodati kategoriju sa ovim ID, jer vec postoji.';
        }

        res.render('pages/add-kategorije', {
            siteTitle: 'Dodavanje',
            pageTitle: "Dodavanje nove kategorije",
            pgoLista: pgoLista,
            message: message
        });

        return;
    }

    res.redirect('/kategorije');
});
// KOMPETENCIJE
// get add za ulazak u formu
/**
 * @swagger
 * /kategorije/add-kompetencija:
 *  get:
 *    description: Pristupa add formi za KATEGORIJE > KOMPETENCIJE
 *    responses:
 *      '200':
 *          description: Uspesno otvorena forma
 */
app.get('/kategorije/add-kompetencija/:polje/:grupa/:oblast/:kategorija', function (req, res) {
    res.render('pages/add-kompetencija', {
        siteTitle: 'Dodavanje kompetencije',
        pageTitle: "Dodavanje : "
    });
});

// KOMPETENCIJE
// post add, za dodavanje izmenjenog sadrzaja
/**
 * @swagger
 * /kategorije/add-kompetencija:
 *  post:
 *    description: Dodavanje sadrzaja u tabelu KATEGORIJE > KOMPETENCIJE
 *    responses:
 *      '200':
 *          description: Uspesno prosledjeni podaci u tabelu KATEGORIJE > KOMPETENCIJE
 */
app.post('/kategorije/add-kompetencija/:polje/:grupa/:oblast/:kategorija', function (req, res) {
    connection.query(`
        INSERT kompetencije SET
            KO_KOMPETENCIJA = ?,
            KO_NAZIV = ?,
            KO_OPIS = ?,
            PO_POLJE = ?,
            GRU_GRUPA = ?,
            OBL_OBLAST = ?,
            KOMP_KATEGORIJA = ?`,
        [
            req.body.KO_KOMPETENCIJA,
            req.body.KO_NAZIV, // Edit:
            req.body.KO_OPIS,
            req.params.polje,// Find
            req.params.grupa,
            req.params.oblast,
            req.params.kategorija
        ]
    );

    neo4jConnection.session().run('MATCH (kat:Kategorija { kategorija_id: $katId }) CREATE (k:Kompetencija { kompetencija_id: $id, naziv: $naziv, opis: $opis })-[p:Pripada]->(kat) RETURN k, p, kat', {
        id: req.body.KO_KOMPETENCIJA,
        naziv: req.body.KO_NAZIV,
        opis: req.body.KO_OPIS,
        katId: req.params.kategorija,
    }).subscribe({
        next: data => console.log('Next add kompetencija: ', data),
        complete: () => console.log('Completed add kompetencija'),
        error: err => console.log('Error add kompetencija: ', error)
      });

    console.log('Izvrsavamna neo4j: ', [
        'MATCH (kat:Kategorija { kategorija_id: $katId }) CREATE (k:Kompetencija { kompetencija_id: $id, naziv: $naziv, opis: $opis })-[p:Pripada]->(kat) RETURN k, p, kat', {
            id: req.body.KO_KOMPETENCIJA,
            naziv: req.body.KO_NAZIV,
            opis: req.body.KO_OPIS,
            katId: req.params.kategorija,
        }
    ]);

    res.redirect('/kategorije');
});
// KOMPETENCIJE
// get edit za ulazak u formu
/**
 * @swagger
 * /kompetencija/edit-kompetencija:
 *  get:
 *    description: Pristupa edit formi za KATEGORIJE > KOMPETENCIJE
 *    responses:
 *      '200':
 *          description: Uspesno otvorena forma
 */
app.get('/kompetencija/edit-kompetencija/:kompetencija', function (req, res) {
    let result = connection.query(`
        SELECT
            *
        FROM
            kompetencije
        WHERE
            KO_KOMPETENCIJA = ?`, [req.params.kompetencija]);

    res.render('pages/edit-kompetencija', {
        siteTitle: 'Izmena',
        pageTitle: "Izmena : " + result[0].KO_NAZIV,
        item: result[0]
    });
});

// KOMPETENCIJE
// post edit, za izvrsavanje izmenjenog sadrzaja
/**
 * @swagger
 * /kompetencija/edit-kompetencija:
 *  post:
 *    description: Izmena sadrzaja u tabeli KATEGORIJE > KOMPETENCIJE
 *    responses:
 *      '200':
 *          description: Uspesno izmenjen sadrzaj u tabeli KATEGORIJE > KOMPETENCIJE
 */
app.post('/kompetencija/edit-kompetencija/:kompetencija', function (req, res) {
    connection.query(`
    UPDATE kompetencije SET 
        KO_NAZIV = ?,
        KO_OPIS = ?
    WHERE
        KO_KOMPETENCIJA = ?`,
        [
            req.body.KO_NAZIV, // Edit:
            req.body.KO_OPIS,
            req.params.kompetencija // Find:
        ]
    );

    neo4jConnection.session().run('MATCH (kom:Kompetencija { kompetencija_id: $komId }) SET kom.naziv = $naziv, kom.opis = $opis RETURN kom;', {
        komId: req.params.kompetencija,
        naziv: req.body.KO_NAZIV,
        opis: req.body.KO_OPIS
    }).subscribe({
        next: data => console.log('Next edit kompetencija: ', data),
        complete: () => console.log('Completed edit kompetencija'),
        error: err => console.log('Error edit kompetencija: ', error)
      });

    res.redirect('/kategorije');
});
// DELETE KOMPETENCIJE
// delete metod
/**
 * @swagger
 * /kompetencija/delete-kompetencije:
 *  get:
 *    description: Brisanje sadrzaja iz tabele KATEGORIJE > KOMPETENCIJE
 *    responses:
 *      '200':
 *          description: Uspesno obrisan sadrzaj iz tabele KATEGORIJE > KOMPETENCIJE
 */
app.get('/kompetencija/delete-kompetencije/:kompetencija', function (req, res) {
    connection.query(`DELETE FROM lista_kompetencija WHERE KO_KOMPETENCIJA = ?`, [req.params.kompetencija]);
    connection.query(`DELETE FROM fondovi_po_kompetencijama WHERE KO_KOMPETENCIJA = ?`, [req.params.kompetencija]);
    connection.query(`DELETE FROM povezane_kompetencije WHERE KO_KOMPETENCIJA = ?`, [req.params.kompetencija]);
    connection.query(`DELETE FROM strukturirane_kompetencije WHERE KO_KOMPETENCIJA = ?`, [req.params.kompetencija]);
    connection.query(`DELETE FROM strukturirane_kompetencije WHERE KOM_KO_KOMPETENCIJA = ?`, [req.params.kompetencija]);
    connection.query(`DELETE FROM kompetencije WHERE KO_KOMPETENCIJA = ?`, [req.params.kompetencija]);

    neo4jConnection.session().run('MATCH (k:Kompetencija { kompetencija_id: $id }) DETACH DELETE k', {
        id: req.params.kompetencija
    });

    res.redirect('/kategorije');
});

/**
 * @swagger
 * /kategorije/delete:
 *  get:
 *    description: Brisanje sadrzaja iz tabele KATEGORIJE
 *    responses:
 *      '200':
 *          description: Uspesno obrisan sadrzaj iz tabele KATEGORIJE
 */
// delete metod
app.get('/kategorije/delete/:polje/:grupa/:oblast/:kategorija', function (req, res) {
    connection.query(`DELETE FROM lista_kompetencija WHERE KOMP_KATEGORIJA = ?`, [req.params.kategorija]);
    connection.query(`DELETE FROM fondovi_po_kompetencijama WHERE KOMP_KATEGORIJA = ?`, [req.params.kategorija]);
    connection.query(`DELETE FROM kompetencije WHERE KOMP_KATEGORIJA = ?`, [req.params.kategorija]);
    connection.query(`DELETE FROM povezane_kompetencije WHERE KOMP_KATEGORIJA = ?`, [req.params.kategorija]);
    connection.query(`DELETE FROM strukturirane_kategorije WHERE KOMP_KATEGORIJA = ?`, [req.params.kategorija]);
    connection.query(`DELETE FROM strukturirane_kategorije WHERE KAT_KOMP_KATEGORIJA = ?`, [req.params.kategorija]);
    connection.query(`DELETE FROM strukturirane_kompetencije WHERE KOMP_KATEGORIJA = ?`, [req.params.kategorija]);
    connection.query(`DELETE FROM strukturirane_kompetencije WHERE KOM_KO_KOMPETENCIJA = ?`, [req.params.kategorija]);

    connection.query(`
        DELETE FROM
            kategorija_kompetencije
        WHERE
            PO_POLJE = ? AND
            GRU_GRUPA = ? AND
            OBL_OBLAST = ? AND
            KOMP_KATEGORIJA = ?`,
        [
            req.params.polje, // Find
            req.params.grupa,
            req.params.oblast,
            req.params.kategorija
        ]
    );

    neo4jConnection.session().run('MATCH (kom:Kompetencija)-[p:Pripada]->(kat:Kategorija { kategorija_id: $id }) DETACH DELETE p, kom, kat;', {
        id: req.params.kategorija
    }).subscribe({
        next: data => console.log('Next delete kategorije i kompetencija: ', data),
        complete: () => console.log('Completed delete kategorije i kompetencija'),
        error: err => console.log('Error delete kategorije i kompetencija: ', error)
      });

    res.redirect('/kategorije');
});

// kategorije
/**
 * @swagger
 * /kategorije:
 *  get:
 *    description: Prikazuje podatke iz tabele KATEGORIJE
 *    responses:
 *      '200':
 *          description: Uspesno prikazani podaci iz tabele KATEGORIJE
 */
app.get('/kategorije', function (req, res) {
    let kategorije = [];

    let result = connection.query("SELECT * FROM kategorija_kompetencije ORDER BY KOMP_NAZIV;");

    for (let record of result) {
        let kategorija = {
            naziv: record.KOMP_NAZIV,
            opis: record.KOMP_OPIS,
            oblast: record.OBL_OBLAST,
            PO_POLJE: record.PO_POLJE,
            GRU_GRUPA: record.GRU_GRUPA,
            OBL_OBLAST: record.OBL_OBLAST,
            KOMP_KATEGORIJA: record.KOMP_KATEGORIJA,
            kompetencije: []
        };

        let result2 = connection.query("SELECT * FROM kompetencije WHERE PO_POLJE = ? AND GRU_GRUPA = ? AND OBL_OBLAST = ? AND KOMP_KATEGORIJA = ? ORDER BY KO_NAZIV", [record.PO_POLJE, record.GRU_GRUPA, record.OBL_OBLAST, record.KOMP_KATEGORIJA]);

        for (let record2 of result2) {
            let kompetencija = {
                id: record2.KO_KOMPETENCIJA,
                naziv: record2.KO_NAZIV,
                opis: record2.KO_OPIS
            };

            kategorija.kompetencije.push(kompetencija);
        }

        kategorije.push(kategorija);
    }

    res.render('transform/findKategorije', {
        siteTitle: 'Prikaz kategorija',
        pageTitle: 'Prikaz kategorija',
        kategorije: kategorije,
        kategorijeJson: JSON.stringify(kategorije, null, 4)
    });
});
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



// TABELA PREDMETI //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Prikaz svih predmeta -> tabela
/**
 * @swagger
 * /predmeti:
 *  get:
 *    description: Prikazuje podatke iz tabele PREDMETI
 *    responses:
 *      '200':
 *          description: Uspesno prikazani podaci iz tabele PREDMETI
 */
app.get('/predmeti', function (req, res) {
    let predmeti = [];

    let result = connection.query(`
        SELECT
            pr.*,
            vn.VID_VID AS vid_id,
            vn.VID_NAZIV AS vid_nastave_naziv,
            IFNULL(GROUP_CONCAT(k.KO_NAZIV SEPARATOR ", "), "- - -") AS kompetencije,
            fv.FOND_UKUPNO_CASOVA AS broj_casova,
            vna.VID_NAZIV AS vid_naziv,
            tu.TIP_NAZIV AS tip_ustanove_naziv
        FROM
            nastavni_predmeti AS pr
        INNER JOIN fondovi_po_vidu AS fpv ON
            pr.TIP_UST          = fpv.TIP_UST AND
            pr.VU_IDENTIFIKATOR = fpv.VU_IDENTIFIKATOR AND
            pr.NP_PREDMET       = fpv.NP_PREDMET AND
            pr.NP_VERZIJA       = fpv.NP_VERZIJA
        INNER JOIN vidovi_nastave AS vn ON fpv.VID_VID = vn.VID_VID
        LEFT JOIN lista_kompetencija AS lk ON
            pr.TIP_UST          = lk.TIP_UST AND
            pr.VU_IDENTIFIKATOR = lk.VU_IDENTIFIKATOR AND
            pr.NP_PREDMET       = lk.NP_PREDMET AND
            pr.NP_VERZIJA       = lk.NP_VERZIJA
        LEFT JOIN kompetencije AS k ON k.KO_KOMPETENCIJA = lk.KO_KOMPETENCIJA
        INNER JOIN fondovi_po_vidu AS fv ON fv.NP_PREDMET = pr.NP_PREDMET AND fv.NP_VERZIJA = pr.NP_VERZIJA
        INNER JOIN vidovi_nastave AS vna ON fv.VID_VID = vna.VID_VID
        INNER JOIN tipovi_ustanova AS tu ON tu.TIP_UST = pr.TIP_UST
        GROUP BY
            pr.TIP_UST,
            pr.VU_IDENTIFIKATOR,
            pr.NP_PREDMET,
            pr.NP_VERZIJA
        ORDER BY
            pr.NP_PREDMET;`);

    for (let record of result) {
        let predmet = {
            naziv: record.NP_NAZIV_PREDMETA,
            izbor: record.NP_IZBORNA ? 'izborni' : 'obavezan',
            tip: record.TIP_UST,
            tipUstanoveNaziv: record.tip_ustanove_naziv,
            identifikator: record.VU_IDENTIFIKATOR,
            akronim: record.NP_PREDMET,
            verzija: record.NP_VERZIJA,
            vidNastave: record.vid_nastave_naziv,
            kompetencijeImena: record.kompetencije,
            kompetencije: connection.query(`
                SELECT
                    k.KO_NAZIV AS naziv,
                    k.KO_OPIS AS opis,
                    kk.KOMP_NAZIV AS nazivKategorija,
                    kk.KOMP_OPIS AS opisKategorije
                FROM
                    kompetencije AS k
                INNER JOIN kategorija_kompetencije AS kk ON k.KOMP_KATEGORIJA = kk.KOMP_KATEGORIJA
                INNER JOIN lista_kompetencija AS lk ON lk.NP_PREDMET = ? AND NP_VERZIJA = ? AND lk.KO_KOMPETENCIJA = k.KO_KOMPETENCIJA
                ORDER BY
                    k.KO_NAZIV;
            `, [ record.NP_PREDMET, record.NP_VERZIJA ]),
            brojCasova: record.broj_casova,
            vidNaziv: record.vid_naziv,
        };

        predmeti.push(predmet);
    }

    res.render('transform/findPredmeti', {
        siteTitle: 'Prikaz predmeta',
        pageTitle: 'Prikaz predmeta',
        predmeti: predmeti
    });
});

// GET metoda za ulazak u formu ADD
/**
 * @swagger
 * /predmeti/add:
 *  get:
 *    description: Pristup formi za dodavanje podataka u tabelu PREDMETI
 *    responses:
 *      '200':
 *          description: Uspesno izmenjen sadrzaj u tabeli KATEGORIJE > KOMPETENCIJE
 */
app.get('/predmeti/add', function (req, res) {
    let ustanove = connection.query(`SELECT CONCAT(TIP_UST, '/', VU_IDENTIFIKATOR) AS "key", VU_NAZIV AS "value" FROM visokoskolska_ustanova ORDER BY VU_NAZIV;`);

    res.render('pages/add-predmeti', {
        siteTitle: 'Dodaj predmet',
        pageTitle: 'Dodaj predmet',
        ustanove: ustanove,
        message: ''
    });
});

// POST metoda za ADD formu
/**
 * @swagger
 * /predmeti/add:
 *  post:
 *    description: Dodavanje sadržaja u tabelu PREDMETI
 *    responses:
 *      '200':
 *          description: Uspesno dodati podaci u tabelu PREDMETI
 */
app.post('/predmeti/add', function (req, res) {
    try {
        const ustanovaDelovi = req.body.USTANOVA.split('/');

        const tipUstanove = ustanovaDelovi[0];
        const vuIdentifikator = ustanovaDelovi[1];

        const deloviVida = req.body.FOND_NACIN_IZVO_ENJA.split('/');
        const vidId = deloviVida[0];
        const nacin = deloviVida[1];

        connection.query(`
            INSERT nastavni_predmeti
            SET
                NP_PREDMET = ?,
                NP_VERZIJA = ?,
                NP_NAZIV_PREDMETA = ?,
                NP_IZBORNA = ?,
                TIP_UST = ?,
                VU_IDENTIFIKATOR = ?;`,
            [
                req.body.NP_PREDMET,
                req.body.NP_VERZIJA,
                req.body.NP_NAZIV_PREDMETA,
                req.body.NP_IZBORNA,
                tipUstanove,
                vuIdentifikator
            ]);

        connection.query(`
            INSERT INTO fondovi_po_vidu
            SET
                TIP_UST = ?,
                VU_IDENTIFIKATOR = ?,
                NP_PREDMET = ?,
                NP_VERZIJA = ?,
                VID_VID = ?,
                FOND_NACIN_IZVO_ENJA = ?,
                FOND_UKUPNO_CASOVA = ?`,
            [
                tipUstanove,
                vuIdentifikator,
                req.body.NP_PREDMET,
                req.body.NP_VERZIJA,
                vidId,
                nacin,
                req.body.broj_casova
            ]);

            neo4jConnection.session().run('CREATE (p:Predmet { predmet_id: $id, naziv: $naziv, izborni: $izborni, broj_casova: $brojCasova, nacin_izvodjenja: $nacinIzvodjenja }) RETURN p', {
                id: req.body.NP_PREDMET,
                naziv: req.body.NP_NAZIV_PREDMETA,
                izborni: req.body.NP_IZBORNA,
                brojCasova: req.body.broj_casova,
                nacinIzvodjenja: nacin
            });
    } catch (e) {
        res.render('pages/add-predmeti', {
            siteTitle: 'Dodaj predmet',
            pageTitle: 'Dodaj predmet',
            ustanove: connection.query(`SELECT CONCAT(TIP_UST, '/', VU_IDENTIFIKATOR) AS "key", VU_NAZIV AS "value" FROM visokoskolska_ustanova ORDER BY VU_NAZIV;`),
            message: 'Doslo je do greske prilikom unosa predmete. Detalji greske: ' + JSON.stringify(e)
        });

        return;
    }

    res.redirect('/predmeti/');
});


// GET metoda za ulazak u EDIT formu
/**
 * @swagger
 * /predmeti/edit:
 *  get:
 *    description: Pristup formi za izmenu podataka u tabeli PREDMETI
 *    responses:
 *      '200':
 *          description: Uspesno prikazani podaci u formi PREDMETI
 */
app.get('/predmeti/edit/:akronim/:verzija', function (req, res) {
    let predmet = connection.query(`
        SELECT
            pr.*,
            fpv.FOND_UKUPNO_CASOVA AS broj_casova,
            fpv.FOND_NACIN_IZVO_ENJA,
            fpv.VID_VID
        FROM
            nastavni_predmeti AS pr
            INNER JOIN fondovi_po_vidu AS fpv ON
                fpv.TIP_UST = pr.TIP_UST AND
                fpv.VU_IDENTIFIKATOR = pr.VU_IDENTIFIKATOR AND
                fpv.NP_PREDMET = pr.NP_PREDMET AND
                fpv.NP_VERZIJA = pr.NP_VERZIJA
        WHERE
            pr.NP_PREDMET = ? AND
            pr.NP_VERZIJA = ?;`, [
        req.params.akronim,
        req.params.verzija
    ]);
    res.render('pages/edit-predmeti', {
        siteTitle: 'Izmena',
        pageTitle: "Izmena : " + predmet[0].NP_NAZIV_PREDMETA,
        item: predmet[0],
        ustanove: connection.query(`SELECT CONCAT(TIP_UST, '/', VU_IDENTIFIKATOR) AS "key", VU_NAZIV AS "value" FROM visokoskolska_ustanova ORDER BY VU_NAZIV;`),
    });
});

// POST metoda za EDIT 
/**
 * @swagger
 * /predmeti/edit:
 *  post:
 *    description: Izmena podataka u tabeli PREDMETI
 *    responses:
 *      '200':
 *          description: Uspesno izmenjeni podaci u tabeli PREDMETI
 */
app.post('/predmeti/edit/:akronim/:verzija', function (req, res) {
    const deloviVida = req.body.FOND_NACIN_IZVO_ENJA.split('/');
    const vidId = deloviVida[0];
    const nacin = deloviVida[1];

    connection.query(`
        UPDATE nastavni_predmeti
            SET 
                NP_NAZIV_PREDMETA = ?,
                NP_IZBORNA = ?
            WHERE
                NP_PREDMET = ? AND
                NP_VERZIJA
        `,
        [
            // Set:
            req.body.NP_NAZIV_PREDMETA,
            req.body.NP_IZBORNA,

            // Where:
            req.params.akronim,
            req.params.verzija
        ]
    );

    connection.query(`
        UPDATE fondovi_po_vidu
        SET
            VID_VID = ?,
            FOND_NACIN_IZVO_ENJA = ?,
            FOND_UKUPNO_CASOVA = ?
        WHERE
            NP_PREDMET = ? AND
            NP_VERZIJA = ?`,
        [
            // Set:
            vidId,
            nacin,
            req.body.broj_casova,

            // Where:
            req.params.akronim,
            req.params.verzija
        ]);

    neo4jConnection.session().run('MATCH (p:Predmet { predmet_id: $id }) SET p.naziv = $naziv, p.izborni = $izborni, p.broj_casova = $brojCasova, p.nacin_izvodjenja = $nacinIzvodjenja RETURN p', {
        id: req.params.akronim,
        naziv: req.body.NP_NAZIV_PREDMETA,
        izborni: req.body.NP_IZBORNA,
        brojCasova: req.body.broj_casova,
        nacinIzvodjenja: nacin
    }).subscribe({
        next: data => console.log('Next edit predmet: ', data),
        complete: () => console.log('Completed edit predmet'),
        error: err => console.log('Error edit predmet: ', error)
      });

    res.redirect('/predmeti');
});

// KOMPETENCIJE -> PREDMET
// get edit za ulazak u formu
/**
 * @swagger
 * /predmeti/edit-predmet-kompetencija:
 *  get:
 *    description: Pristup formi za izmenu podataka u tabeli PREDMETI > KOMPETENCIJE
 *    responses:
 *      '200':
 *          description: Uspesno prikazani podaci u formi PREDMETI > KOMPETENCIJE
 */
app.get('/predmeti/edit-predmet-kompetencija/:kompetencija', function (req, res) {
    let result = connection.query(`
        SELECT
            *
        FROM
            kompetencije
        WHERE
            KO_KOMPETENCIJA = ?`, [req.params.kompetencija]);

    res.render('pages/edit-predmet-kompetencija', {
        siteTitle: 'Izmena',
        pageTitle: "Izmena : " + result[0].KO_NAZIV,
        item: result[0]
    });
});

// KOMPETENCIJE
// post edit, za izvrsavanje izmenjenog sadrzaja
/**
 * @swagger
 * /predmeti/edit-predmet-kompetencija:
 *  post:
 *    description: Izmena podataka u tabeli PREDMETI > KOMPETENCIJE
 *    responses:
 *      '200':
 *          description: Uspesno izmenjeni podaci u tabeli PREDMETI > KOMPETENCIJE
 */
/*app.post('/predmeti/edit-predmet-kompetencija/:kompetencija', function (req, res) {
    connection.query(`
    UPDATE kompetencije SET 
        KO_NAZIV = ?,
        KO_OPIS = ?
    WHERE
        KO_KOMPETENCIJA = ?`,
        [
            req.body.KO_NAZIV, // Edit:
            req.body.KO_OPIS,
            req.params.kompetencija // Find:
        ]
    );

    res.redirect('/predmeti');
});*/


// delete metod -> PREDMETI
/**
 * @swagger
 * /predmeti/delete:
 *  get:
 *    description: Brisanje podataka iz tabele PREDMETI
 *    responses:
 *      '200':
 *          description: Uspesno obrisani podaci iz tabele PREDMETI 
 */
app.get('/predmeti/delete/:akronim/:verzija', function (req, res) {
    connection.query(`DELETE FROM lista_kompetencija WHERE NP_PREDMET = ? AND NP_VERZIJA = ?;`, [ req.params.akronim, req.params.verzija ]);
    connection.query(`DELETE FROM fondovi_po_vidu WHERE NP_PREDMET = ? AND NP_VERZIJA = ?;`, [ req.params.akronim, req.params.verzija ]);
    connection.query(`DELETE FROM nastavni_predmeti WHERE NP_PREDMET = ? AND NP_VERZIJA = ?;`, [ req.params.akronim, req.params.verzija ]);

    neo4jConnection.session().run('MATCH (p:Predmet) WHERE p.predmet_id = $predmetId DETACH DELETE p', {
        predmetId: req.params.akronim
    });

    res.redirect('/predmeti');
});

/**
 * @swagger
 * /predmeti/kompetencije:
 *  get:
 *    description: Prikaz kompetencija iz tabele PREDMETI > KOMPETENCIJE
 *    responses:
 *      '200':
 *          description: Uspesno prikazani podaci iz tabele PREDMETI > KOMPETENCIJE 
 */
app.get('/predmeti/kompetencije/:akronim/:verzija', function (req, res) {
    const predmeti = connection.query('SELECT NP_NAZIV_PREDMETA FROM nastavni_predmeti WHERE NP_PREDMET = ? AND NP_VERZIJA = ?;', [ req.params.akronim, req.params.verzija ]);
    const imePredmeta = predmeti[0].NP_NAZIV_PREDMETA;
    const kompetencije = connection.query(`
        SELECT
            lk.*,
            k.*
        FROM
            lista_kompetencija AS lk
            INNER JOIN kompetencije AS k ON lk.KO_KOMPETENCIJA = k.KO_KOMPETENCIJA
        WHERE
            lk.NP_PREDMET = ? AND
            lk.NP_VERZIJA = ?
        ORDER BY
            k.KO_NAZIV;`,
    [ req.params.akronim, req.params.verzija ]);

    res.render('pages/list-predmet-kompetencije', {
        siteTitle: 'Kompetencije predmeta ' + imePredmeta,
        pageTitle: "Kompetencije predmeta: " + imePredmeta,
        akronim: req.params.akronim,
        verzija: req.params.verzija,
        imePredmeta: imePredmeta,
        kompetencije: kompetencije
    });
});

/**
 * @swagger
 * /predmeti/addKompetencija:
 *  get:
 *    description: Prikaz forme za dodavanje podataka u tabelu PREDMETI > KOMPETENCIJA 
 *    responses:
 *      '200':
 *          description: Uspesno prikazana forma za dodavanje podataka u tabelu PREDMETI > KOMPETENCIJA 
 */
app.get('/predmeti/addKompetencija/:akronim/:verzija', function (req, res) {
    const predmeti = connection.query('SELECT NP_NAZIV_PREDMETA FROM nastavni_predmeti WHERE NP_PREDMET = ? AND NP_VERZIJA = ?;', [ req.params.akronim, req.params.verzija ]);
    const imePredmeta = predmeti[0].NP_NAZIV_PREDMETA;
    const kompetencije = connection.query(`
        SELECT
            *
        FROM
            kompetencije
        WHERE
            KO_KOMPETENCIJA NOT IN (
                SELECT KO_KOMPETENCIJA FROM lista_kompetencija WHERE NP_PREDMET = ? AND NP_VERZIJA = ?
            )
        ORDER BY
            KO_NAZIV;`,
    [ req.params.akronim, req.params.verzija ]);

    res.render('pages/add-predmet-kompetencija', {
        siteTitle: 'Dodavanje kompetencije predmetu ' + imePredmeta,
        pageTitle: "Dodavanje kompetencije predmetu " + imePredmeta,
        akronim: req.params.akronim,
        verzija: req.params.verzija,
        imePredmeta: imePredmeta,
        kompetencije: kompetencije
    });
});

/**
 * @swagger
 * /predmeti/addKompetencija:
 *  post:
 *    description: Dodavanje podataka u tabelu PREDMETI > KOMPETENCIJA 
 *    responses:
 *      '200':
 *          description: Uspesno dodati podaci u tabelu PREDMETI > KOMPETENCIJA 
 */
app.post('/predmeti/addKompetencija/:akronim/:verzija', function (req, res) {
    const predmet = connection.query('SELECT * FROM nastavni_predmeti WHERE NP_PREDMET = ? AND NP_VERZIJA = ?;', [ req.params.akronim, req.params.verzija ])[0];
    
    const delovi = req.body.kompetencija.split('/');

    const PO_POLJE = delovi[0];
    const GRU_GRUPA = delovi[1];
    const OBL_OBLAST = delovi[2];
    const KOMP_KATEGORIJA = delovi[3];
    const KO_KOMPETENCIJA = delovi[4];

    connection.query(`
        INSERT lista_kompetencija
        SET
            TIP_UST = ?,
            VU_IDENTIFIKATOR = ?,
            NP_PREDMET = ?,
            NP_VERZIJA = ?,
            PO_POLJE = ?,
            GRU_GRUPA = ?,
            OBL_OBLAST = ?,
            KOMP_KATEGORIJA = ?,
            KO_KOMPETENCIJA = ?
    `, [
        predmet.TIP_UST,
        predmet.VU_IDENTIFIKATOR,
        predmet.NP_PREDMET,
        predmet.NP_VERZIJA,

        PO_POLJE,
        GRU_GRUPA,
        OBL_OBLAST,
        KOMP_KATEGORIJA,
        KO_KOMPETENCIJA
    ]);

    neo4jConnection.session().run('MATCH (p:Predmet), (k:Kompetencija) WHERE p.predmet_id = $predmetId AND k.kompetencija_id = $kompetencijaId CREATE (p)-[z:Zahteva]->(k) RETURN z, p, k', {
        predmetId: predmet.NP_PREDMET,
        kompetencijaId: KO_KOMPETENCIJA
    });

    res.redirect('/predmeti/kompetencije/' + req.params.akronim + '/' + req.params.verzija + '/');
});

/**
 * @swagger
 * /predmeti/deleteKompetencija:
 *  get:
 *    description: Brisanje podataka iz tabele PREDMETI > KOMPETENCIJA
 *    responses:
 *      '200':
 *          description: Uspesno obrisani podaci iz tabele PREDMETI > KOMPETENCIJA 
 */
app.get('/predmeti/deleteKompetencija/:akronim/:verzija/:kompetencijaId/', (req, res) => {
    connection.query(
        `DELETE FROM lista_kompetencija WHERE NP_PREDMET = ? AND NP_VERZIJA = ? AND KO_KOMPETENCIJA = ?`, 
        [  req.params.akronim, req.params.verzija, req.params.kompetencijaId ]
    );
    
    neo4jConnection.session().run('MATCH (p:Predmet)-[z:Zahteva]->(k:Kompetencija) WHERE k.kompetencija_id = $kompetencijaId AND p.predmet_id = $predmetId DETACH DELETE z;', {
        predmetId: req.params.akronim,
        kompetencijaId: req.params.kompetencijaId
    });

    res.redirect('/predmeti/kompetencije/' + req.params.akronim + '/' + req.params.verzija + '/');
});

/**
 * @swagger
 * /kategorije/saveDocument:
 *  get:
 *    description: Hvatanje podataka iz tabelu KATEGORIJE za cuvanje u MongoDB 
 *    responses:
 *      '200':
 *          description: Uspesno dohvaceni podaci
 */
app.get('/kategorije/saveDocument', (req, res) => {
    let kategorije = [];

    let result = connection.query("SELECT * FROM kategorija_kompetencije ORDER BY KOMP_NAZIV;");

    for (let record of result) {
        let kategorija = {
            naziv: record.KOMP_NAZIV,
            opis: record.KOMP_OPIS,
            oblast: record.OBL_OBLAST,
            PO_POLJE: record.PO_POLJE,
            GRU_GRUPA: record.GRU_GRUPA,
            OBL_OBLAST: record.OBL_OBLAST,
            KOMP_KATEGORIJA: record.KOMP_KATEGORIJA,
            kompetencije: []
        };

        let result2 = connection.query("SELECT * FROM kompetencije WHERE PO_POLJE = ? AND GRU_GRUPA = ? AND OBL_OBLAST = ? AND KOMP_KATEGORIJA = ? ORDER BY KO_NAZIV", [record.PO_POLJE, record.GRU_GRUPA, record.OBL_OBLAST, record.KOMP_KATEGORIJA]);

        for (let record2 of result2) {
            let kompetencija = {
                id: record2.KO_KOMPETENCIJA,
                naziv: record2.KO_NAZIV,
                opis: record2.KO_OPIS
            };

            kategorija.kompetencije.push(kompetencija);
        }

        kategorije.push(kategorija);
    }

    mongoDB.collection('kategorije').insertOne({
        createdAt: new Date(),
        lista: kategorije
    }, (err, result) => {
        res.redirect('/dokument/kategorije/');
    });
});

/**
 * @swagger
 * /dokument/kategorije:
 *  get:
 *    description: Otvaranje stranice Lista kategorija iz MongoDB 
 *    responses:
 *      '200':
 *          description: Uspesno ispisani podaci
 */
app.get('/dokument/kategorije/', (req, res) => {
    mongoDB.collection('kategorije').find({}).toArray((err, result) => {
        res.render('pages/dokument-kategorije', {
            siteTitle: 'Lista kategorija iz MongoDB',
            pageTitle: "Lista kategorija iz MongoDB",
            kategorije: result
        });
    });
});


/**
 * @swagger
 * /predmeti/saveDocument:
 *  get:
 *    description: Cuvanje podataka kao Mongo dokument 
 *    responses:
 *      '200':
 *          description: Uspesno sacuvani podaci u mongo
 */
app.get('/predmeti/saveDocument', (req, res) => {
    let predmeti = [];

    let result = connection.query(`
        SELECT
            pr.*,
            vn.VID_VID AS vid_id,
            vn.VID_NAZIV AS vid_nastave_naziv,
            IFNULL(GROUP_CONCAT(k.KO_NAZIV SEPARATOR ", "), "- - -") AS kompetencije,
            fv.FOND_UKUPNO_CASOVA AS broj_casova,
            vna.VID_NAZIV AS vid_naziv,
            tu.TIP_NAZIV AS tip_ustanove_naziv
        FROM
            nastavni_predmeti AS pr
        INNER JOIN fondovi_po_vidu AS fpv ON
            pr.TIP_UST          = fpv.TIP_UST AND
            pr.VU_IDENTIFIKATOR = fpv.VU_IDENTIFIKATOR AND
            pr.NP_PREDMET       = fpv.NP_PREDMET AND
            pr.NP_VERZIJA       = fpv.NP_VERZIJA
        INNER JOIN vidovi_nastave AS vn ON fpv.VID_VID = vn.VID_VID
        LEFT JOIN lista_kompetencija AS lk ON
            pr.TIP_UST          = lk.TIP_UST AND
            pr.VU_IDENTIFIKATOR = lk.VU_IDENTIFIKATOR AND
            pr.NP_PREDMET       = lk.NP_PREDMET AND
            pr.NP_VERZIJA       = lk.NP_VERZIJA
        LEFT JOIN kompetencije AS k ON k.KO_KOMPETENCIJA = lk.KO_KOMPETENCIJA
        INNER JOIN fondovi_po_vidu AS fv ON fv.NP_PREDMET = pr.NP_PREDMET AND fv.NP_VERZIJA = pr.NP_VERZIJA
        INNER JOIN vidovi_nastave AS vna ON fv.VID_VID = vna.VID_VID
        INNER JOIN tipovi_ustanova AS tu ON tu.TIP_UST = pr.TIP_UST
        GROUP BY
            pr.TIP_UST,
            pr.VU_IDENTIFIKATOR,
            pr.NP_PREDMET,
            pr.NP_VERZIJA
        ORDER BY
            pr.NP_PREDMET;`);

    for (let record of result) {
        let predmet = {
            naziv: record.NP_NAZIV_PREDMETA,
            izbor: record.NP_IZBORNA ? 'izborni' : 'obavezan',
            tip: record.TIP_UST,
            tipUstanoveNaziv: record.tip_ustanove_naziv,
            identifikator: record.VU_IDENTIFIKATOR,
            akronim: record.NP_PREDMET,
            verzija: record.NP_VERZIJA,
            vidNastave: record.vid_nastave_naziv,
            kompetencijeImena: record.kompetencije,
            kompetencije: connection.query(`
                SELECT
                    k.KO_NAZIV AS naziv,
                    k.KO_OPIS AS opis,
                    kk.KOMP_NAZIV AS nazivKategorija,
                    kk.KOMP_OPIS AS opisKategorije
                FROM
                    kompetencije AS k
                INNER JOIN kategorija_kompetencije AS kk ON k.KOMP_KATEGORIJA = kk.KOMP_KATEGORIJA
                INNER JOIN lista_kompetencija AS lk ON lk.NP_PREDMET = ? AND NP_VERZIJA = ? AND lk.KO_KOMPETENCIJA = k.KO_KOMPETENCIJA
                ORDER BY
                    k.KO_NAZIV;
            `, [ record.NP_PREDMET, record.NP_VERZIJA ]),
            brojCasova: record.broj_casova,
            vidNaziv: record.vid_naziv,
        };

        predmeti.push(predmet);
    }

    mongoDB.collection('predmeti').insertOne({
        createdAt: new Date(),
        lista: predmeti
    }, (err, result) => {
        res.redirect('/dokument/predmeti/');
    });
});


/**
 * @swagger
 * /dokument/predmeti:
 *  get:
 *    description: Otvaranje stranice Lista predmeta iz MongoDB 
 *    responses:
 *      '200':
 *          description: Uspesno ispisani podaci
 */
app.get('/dokument/predmeti/', (req, res) => {
    mongoDB.collection('predmeti').find({}).toArray((err, result) => {
        res.render('pages/dokument-predmeti', {
            siteTitle: 'Lista predmeta iz MongoDB',
            pageTitle: "Lista predmeta iz MongoDB",
            predmeti: result
        });
    });
});
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// konekcija na server
var server = app.listen(4000, function () {
    console.log('Server started on 4000....');
});
