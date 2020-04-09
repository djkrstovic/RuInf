-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.37-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win32
-- HeidiSQL Version:             10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping data for table projekat.akt_o_organizaciji: ~0 rows (approximately)
/*!40000 ALTER TABLE `akt_o_organizaciji` DISABLE KEYS */;
/*!40000 ALTER TABLE `akt_o_organizaciji` ENABLE KEYS */;

-- Dumping data for table projekat.clanovi_podorice: ~0 rows (approximately)
/*!40000 ALTER TABLE `clanovi_podorice` DISABLE KEYS */;
/*!40000 ALTER TABLE `clanovi_podorice` ENABLE KEYS */;

-- Dumping data for table projekat.dodatni_podaci: ~0 rows (approximately)
/*!40000 ALTER TABLE `dodatni_podaci` DISABLE KEYS */;
/*!40000 ALTER TABLE `dodatni_podaci` ENABLE KEYS */;

-- Dumping data for table projekat.dokumenti_o_zaposlenim: ~0 rows (approximately)
/*!40000 ALTER TABLE `dokumenti_o_zaposlenim` DISABLE KEYS */;
/*!40000 ALTER TABLE `dokumenti_o_zaposlenim` ENABLE KEYS */;

-- Dumping data for table projekat.dokumentovanje_predmeta: ~0 rows (approximately)
/*!40000 ALTER TABLE `dokumentovanje_predmeta` DISABLE KEYS */;
/*!40000 ALTER TABLE `dokumentovanje_predmeta` ENABLE KEYS */;

-- Dumping data for table projekat.dokumentovanje_programa: ~0 rows (approximately)
/*!40000 ALTER TABLE `dokumentovanje_programa` DISABLE KEYS */;
/*!40000 ALTER TABLE `dokumentovanje_programa` ENABLE KEYS */;

-- Dumping data for table projekat.dokumentovanje__akreditacije: ~0 rows (approximately)
/*!40000 ALTER TABLE `dokumentovanje__akreditacije` DISABLE KEYS */;
/*!40000 ALTER TABLE `dokumentovanje__akreditacije` ENABLE KEYS */;

-- Dumping data for table projekat.dokument_o_akreditaciji: ~0 rows (approximately)
/*!40000 ALTER TABLE `dokument_o_akreditaciji` DISABLE KEYS */;
/*!40000 ALTER TABLE `dokument_o_akreditaciji` ENABLE KEYS */;

-- Dumping data for table projekat.drzava: ~1 rows (approximately)
/*!40000 ALTER TABLE `drzava` DISABLE KEYS */;
INSERT INTO `drzava` (`DR_IDENTIFIKATOR`, `DR_NAZIV`, `DR_DATUM_OSNIVANJA`, `DR_POSTOJALA_DO`, `DR_GRB`, `DR_ZASTAVA`, `DR_HIMNA`, `DRZ_DR_IDENTIFIKATOR`) VALUES
	('DrI', 'Dr naziv', '2015-01-16', '2020-01-16', _binary 0x3131303030, _binary 0x3131303031, _binary 0x3131303032, 'DrI'),
	('SRB', 'Srbija', '2006-06-05', '2020-01-19', _binary 0x31333839, _binary 0x333831, _binary 0x32303036, 'SRB');
/*!40000 ALTER TABLE `drzava` ENABLE KEYS */;

-- Dumping data for table projekat.fondovi_po_kompetencijama: ~0 rows (approximately)
/*!40000 ALTER TABLE `fondovi_po_kompetencijama` DISABLE KEYS */;
/*!40000 ALTER TABLE `fondovi_po_kompetencijama` ENABLE KEYS */;

-- Dumping data for table projekat.fondovi_po_vidu: ~7 rows (approximately)
/*!40000 ALTER TABLE `fondovi_po_vidu` DISABLE KEYS */;
INSERT INTO `fondovi_po_vidu` (`TIP_UST`, `VU_IDENTIFIKATOR`, `NP_PREDMET`, `NP_VERZIJA`, `VID_VID`, `FOND_UKUPNO_CASOVA`, `FOND_NACIN_IZVO_ENJA`) VALUES
	('A1', 10003, 'BAP101', 1, '2', 40.00, 'K'),
	('F1', 10002, 'MRS101', 4, '1', 50.00, 'G'),
	('F1', 10002, 'TESTPR', 1, '3', 3.00, 'P'),
	('T1', 1111, 'OBPRE', 2, '2', 4.50, 'K'),
	('T1', 1111, 'predme', 22, '2', 30.00, 'K'),
	('V1', 10001, 'AUD101', 5, '3', 15.00, 'P'),
	('V1', 10001, 'JOS1PR', 1, '2', 3.20, 'K');
/*!40000 ALTER TABLE `fondovi_po_vidu` ENABLE KEYS */;

-- Dumping data for table projekat.glavni_gradovi: ~0 rows (approximately)
/*!40000 ALTER TABLE `glavni_gradovi` DISABLE KEYS */;
/*!40000 ALTER TABLE `glavni_gradovi` ENABLE KEYS */;

-- Dumping data for table projekat.istorija_staza: ~0 rows (approximately)
/*!40000 ALTER TABLE `istorija_staza` DISABLE KEYS */;
/*!40000 ALTER TABLE `istorija_staza` ENABLE KEYS */;

-- Dumping data for table projekat.jezici: ~0 rows (approximately)
/*!40000 ALTER TABLE `jezici` DISABLE KEYS */;
/*!40000 ALTER TABLE `jezici` ENABLE KEYS */;

-- Dumping data for table projekat.kategorija_kompetencije: ~5 rows (approximately)
/*!40000 ALTER TABLE `kategorija_kompetencije` DISABLE KEYS */;
INSERT INTO `kategorija_kompetencije` (`PO_POLJE`, `GRU_GRUPA`, `OBL_OBLAST`, `KOMP_KATEGORIJA`, `KOMP_NAZIV`, `KOMP_OPIS`) VALUES
	('dh', 'ek', 'a1', 'ek', 'Drustveno humanisticko polje', 'Ekonomija'),
	('dh', 'ek', 'a1', 'FI', 'Finansije', 'Kategorija finansija'),
	('p1', 'g1', 'o1', 'k1', 'Prirodno matematicko polje1', 'Tekst opisa kategorije za prirodno matematicko polje... sta god.1'),
	('pm', 'bn', 'v1', 'bn', 'Prirodno matematicko polje', 'Biologija'),
	('tt', 'ah', 'f1', 'ah', 'Tehnicko tehnolosko polje', 'Arhitektura');
/*!40000 ALTER TABLE `kategorija_kompetencije` ENABLE KEYS */;

-- Dumping data for table projekat.kompetencije: ~5 rows (approximately)
/*!40000 ALTER TABLE `kompetencije` DISABLE KEYS */;
INSERT INTO `kompetencije` (`PO_POLJE`, `GRU_GRUPA`, `OBL_OBLAST`, `KOMP_KATEGORIJA`, `KO_KOMPETENCIJA`, `KO_NAZIV`, `KO_OPIS`) VALUES
	('dh', 'ek', 'a1', 'ek', 'Dh', 'Ekonomija', 'Opis ekonomije'),
	('dh', 'ek', 'a1', 'FI', 'FT', 'Finansijski tehnicar', 'Neka glupost'),
	('p1', 'g1', 'o1', 'k1', 'Kk', 'Edukacija', 'Ko opis'),
	('pm', 'bn', 'v1', 'bn', 'Pm', 'Biologija', 'Opis biologije'),
	('tt', 'ah', 'f1', 'ah', 'Tt', 'Arhitektura', 'Opis arhitekture');
/*!40000 ALTER TABLE `kompetencije` ENABLE KEYS */;

-- Dumping data for table projekat.kontakt_podaci: ~0 rows (approximately)
/*!40000 ALTER TABLE `kontakt_podaci` DISABLE KEYS */;
/*!40000 ALTER TABLE `kontakt_podaci` ENABLE KEYS */;

-- Dumping data for table projekat.lista_kompetencija: ~4 rows (approximately)
/*!40000 ALTER TABLE `lista_kompetencija` DISABLE KEYS */;
INSERT INTO `lista_kompetencija` (`TIP_UST`, `VU_IDENTIFIKATOR`, `NP_PREDMET`, `NP_VERZIJA`, `PO_POLJE`, `GRU_GRUPA`, `OBL_OBLAST`, `KOMP_KATEGORIJA`, `KO_KOMPETENCIJA`) VALUES
	('A1', 10003, 'BAP101', 1, 'dh', 'ek', 'a1', 'ek', 'Dh'),
	('F1', 10002, 'MRS101', 4, 'tt', 'ah', 'f1', 'ah', 'Tt'),
	('T1', 1111, 'predme', 22, 'p1', 'g1', 'o1', 'k1', 'Kk'),
	('V1', 10001, 'AUD101', 5, 'pm', 'bn', 'v1', 'bn', 'Pm');
/*!40000 ALTER TABLE `lista_kompetencija` ENABLE KEYS */;

-- Dumping data for table projekat.naseljeno_mesto: ~0 rows (approximately)
/*!40000 ALTER TABLE `naseljeno_mesto` DISABLE KEYS */;
INSERT INTO `naseljeno_mesto` (`NM_IDENTIFIKATOR`, `NM_NAZIV`) VALUES
	(1111, 'Nm Naziv'),
	(11000, 'Beograd');
/*!40000 ALTER TABLE `naseljeno_mesto` ENABLE KEYS */;

-- Dumping data for table projekat.nastavni_predmeti: ~8 rows (approximately)
/*!40000 ALTER TABLE `nastavni_predmeti` DISABLE KEYS */;
INSERT INTO `nastavni_predmeti` (`TIP_UST`, `VU_IDENTIFIKATOR`, `NP_PREDMET`, `NP_VERZIJA`, `NP_NAZIV_PREDMETA`, `NP_IZBORNA`) VALUES
	('A1', 10003, 'BAP101', 1, 'Baze podataka', 1),
	('A1', 10003, 'JCO101', 2, 'Java Core', 0),
	('F1', 10002, 'MRS101', 4, 'Metodologija', 0),
	('F1', 10002, 'TESTPR', 1, 'Test predmet', 0),
	('T1', 1111, 'OBPRE', 2, 'Obavezan predmet', 0),
	('T1', 1111, 'predme', 22, 'Naziv predmeta', 1),
	('V1', 10001, 'AUD101', 5, 'Audio tehnologije2', 1),
	('V1', 10001, 'JOS1PR', 1, 'Jos jedan predmet', 1);
/*!40000 ALTER TABLE `nastavni_predmeti` ENABLE KEYS */;

-- Dumping data for table projekat.nivo_studija: ~0 rows (approximately)
/*!40000 ALTER TABLE `nivo_studija` DISABLE KEYS */;
/*!40000 ALTER TABLE `nivo_studija` ENABLE KEYS */;

-- Dumping data for table projekat.obuhvat_akreditacije: ~0 rows (approximately)
/*!40000 ALTER TABLE `obuhvat_akreditacije` DISABLE KEYS */;
/*!40000 ALTER TABLE `obuhvat_akreditacije` ENABLE KEYS */;

-- Dumping data for table projekat.odgovorni_rukovodilac: ~0 rows (approximately)
/*!40000 ALTER TABLE `odgovorni_rukovodilac` DISABLE KEYS */;
/*!40000 ALTER TABLE `odgovorni_rukovodilac` ENABLE KEYS */;

-- Dumping data for table projekat.organizacija_nastave: ~0 rows (approximately)
/*!40000 ALTER TABLE `organizacija_nastave` DISABLE KEYS */;
/*!40000 ALTER TABLE `organizacija_nastave` ENABLE KEYS */;

-- Dumping data for table projekat.organizaciona_sema: ~0 rows (approximately)
/*!40000 ALTER TABLE `organizaciona_sema` DISABLE KEYS */;
/*!40000 ALTER TABLE `organizaciona_sema` ENABLE KEYS */;

-- Dumping data for table projekat.organizacione_jedinice: ~0 rows (approximately)
/*!40000 ALTER TABLE `organizacione_jedinice` DISABLE KEYS */;
/*!40000 ALTER TABLE `organizacione_jedinice` ENABLE KEYS */;

-- Dumping data for table projekat.povezane_kompetencije: ~0 rows (approximately)
/*!40000 ALTER TABLE `povezane_kompetencije` DISABLE KEYS */;
/*!40000 ALTER TABLE `povezane_kompetencije` ENABLE KEYS */;

-- Dumping data for table projekat.pozicije_u_semi: ~0 rows (approximately)
/*!40000 ALTER TABLE `pozicije_u_semi` DISABLE KEYS */;
/*!40000 ALTER TABLE `pozicije_u_semi` ENABLE KEYS */;

-- Dumping data for table projekat.pozicije___funkcije: ~0 rows (approximately)
/*!40000 ALTER TABLE `pozicije___funkcije` DISABLE KEYS */;
/*!40000 ALTER TABLE `pozicije___funkcije` ENABLE KEYS */;

-- Dumping data for table projekat.pravna_lica: ~0 rows (approximately)
/*!40000 ALTER TABLE `pravna_lica` DISABLE KEYS */;
/*!40000 ALTER TABLE `pravna_lica` ENABLE KEYS */;

-- Dumping data for table projekat.radna_mesta: ~0 rows (approximately)
/*!40000 ALTER TABLE `radna_mesta` DISABLE KEYS */;
/*!40000 ALTER TABLE `radna_mesta` ENABLE KEYS */;

-- Dumping data for table projekat.rasporedi_na_radna_mesta: ~0 rows (approximately)
/*!40000 ALTER TABLE `rasporedi_na_radna_mesta` DISABLE KEYS */;
/*!40000 ALTER TABLE `rasporedi_na_radna_mesta` ENABLE KEYS */;

-- Dumping data for table projekat.registar_grupa_obrazovanja: ~10 rows (approximately)
/*!40000 ALTER TABLE `registar_grupa_obrazovanja` DISABLE KEYS */;
INSERT INTO `registar_grupa_obrazovanja` (`PO_POLJE`, `GRU_GRUPA`, `GRU_NAZIV`) VALUES
	('dh', 'ek', 'Ekonomske nauke'),
	('dh', 'pr', 'Pravne nauke'),
	('mn', 'st', 'Stomatoloske nauke'),
	('mn', 'vt', 'Veterinarske nauke'),
	('p1', 'g1', 'Grupa naziv'),
	('p2', 'g2', 'Grupa naziv 2'),
	('pm', 'bn', 'Bioloske nauke'),
	('pm', 'gn', 'Geo nauke'),
	('pm', 'mm', 'Matematicke nauke'),
	('tt', 'ah', 'Arhitektura');
/*!40000 ALTER TABLE `registar_grupa_obrazovanja` ENABLE KEYS */;

-- Dumping data for table projekat.registar_oblasti_obrazovanja: ~5 rows (approximately)
/*!40000 ALTER TABLE `registar_oblasti_obrazovanja` DISABLE KEYS */;
INSERT INTO `registar_oblasti_obrazovanja` (`PO_POLJE`, `GRU_GRUPA`, `OBL_OBLAST`, `OBL_NAZIV`, `OBL_KORPUS`) VALUES
	('dh', 'ek', 'a1', 'Akademska oblast', 1),
	('p1', 'g1', 'o1', 'Oblast naziv', 1),
	('p2', 'g2', 'o2', 'Oblast naziv 2', 1),
	('pm', 'bn', 'v1', 'Visokoskolska oblast', 1),
	('tt', 'ah', 'f1', 'Fakultetsko oblast', 1);
/*!40000 ALTER TABLE `registar_oblasti_obrazovanja` ENABLE KEYS */;

-- Dumping data for table projekat.registar_obrazovnih_polja: ~6 rows (approximately)
/*!40000 ALTER TABLE `registar_obrazovnih_polja` DISABLE KEYS */;
INSERT INTO `registar_obrazovnih_polja` (`PO_POLJE`, `PO_NAZIV`) VALUES
	('dh', 'Drustveno humanisticke nauke'),
	('mn', 'Medicinske nauke'),
	('p1', 'Polje Naziv'),
	('p2', 'Naziv polja p2'),
	('pm', 'Prirodno matematicke nauke'),
	('tt', 'Tehnicko tehnoloske nauke');
/*!40000 ALTER TABLE `registar_obrazovnih_polja` ENABLE KEYS */;

-- Dumping data for table projekat.registar_strucnih_naziva: ~0 rows (approximately)
/*!40000 ALTER TABLE `registar_strucnih_naziva` DISABLE KEYS */;
/*!40000 ALTER TABLE `registar_strucnih_naziva` ENABLE KEYS */;

-- Dumping data for table projekat.registar_zaposlenih: ~0 rows (approximately)
/*!40000 ALTER TABLE `registar_zaposlenih` DISABLE KEYS */;
/*!40000 ALTER TABLE `registar_zaposlenih` ENABLE KEYS */;

-- Dumping data for table projekat.registrovani_programi: ~0 rows (approximately)
/*!40000 ALTER TABLE `registrovani_programi` DISABLE KEYS */;
/*!40000 ALTER TABLE `registrovani_programi` ENABLE KEYS */;

-- Dumping data for table projekat.rukovodna_sema: ~0 rows (approximately)
/*!40000 ALTER TABLE `rukovodna_sema` DISABLE KEYS */;
/*!40000 ALTER TABLE `rukovodna_sema` ENABLE KEYS */;

-- Dumping data for table projekat.sastav_jedinice: ~0 rows (approximately)
/*!40000 ALTER TABLE `sastav_jedinice` DISABLE KEYS */;
/*!40000 ALTER TABLE `sastav_jedinice` ENABLE KEYS */;

-- Dumping data for table projekat.sastav_slozene_ustanove: ~0 rows (approximately)
/*!40000 ALTER TABLE `sastav_slozene_ustanove` DISABLE KEYS */;
/*!40000 ALTER TABLE `sastav_slozene_ustanove` ENABLE KEYS */;

-- Dumping data for table projekat.skolpleni_sa: ~0 rows (approximately)
/*!40000 ALTER TABLE `skolpleni_sa` DISABLE KEYS */;
/*!40000 ALTER TABLE `skolpleni_sa` ENABLE KEYS */;

-- Dumping data for table projekat.slozena_drzava: ~0 rows (approximately)
/*!40000 ALTER TABLE `slozena_drzava` DISABLE KEYS */;
/*!40000 ALTER TABLE `slozena_drzava` ENABLE KEYS */;

-- Dumping data for table projekat.sluzbeni_jezici: ~0 rows (approximately)
/*!40000 ALTER TABLE `sluzbeni_jezici` DISABLE KEYS */;
/*!40000 ALTER TABLE `sluzbeni_jezici` ENABLE KEYS */;

-- Dumping data for table projekat.stepen_studija: ~0 rows (approximately)
/*!40000 ALTER TABLE `stepen_studija` DISABLE KEYS */;
/*!40000 ALTER TABLE `stepen_studija` ENABLE KEYS */;

-- Dumping data for table projekat.struktura_dokumentacije: ~0 rows (approximately)
/*!40000 ALTER TABLE `struktura_dokumentacije` DISABLE KEYS */;
/*!40000 ALTER TABLE `struktura_dokumentacije` ENABLE KEYS */;

-- Dumping data for table projekat.struktura_programa: ~0 rows (approximately)
/*!40000 ALTER TABLE `struktura_programa` DISABLE KEYS */;
/*!40000 ALTER TABLE `struktura_programa` ENABLE KEYS */;

-- Dumping data for table projekat.strukturirane_kategorije: ~0 rows (approximately)
/*!40000 ALTER TABLE `strukturirane_kategorije` DISABLE KEYS */;
/*!40000 ALTER TABLE `strukturirane_kategorije` ENABLE KEYS */;

-- Dumping data for table projekat.strukturirane_kompetencije: ~0 rows (approximately)
/*!40000 ALTER TABLE `strukturirane_kompetencije` DISABLE KEYS */;
/*!40000 ALTER TABLE `strukturirane_kompetencije` ENABLE KEYS */;

-- Dumping data for table projekat.tipovi_ustanova: ~4 rows (approximately)
/*!40000 ALTER TABLE `tipovi_ustanova` DISABLE KEYS */;
INSERT INTO `tipovi_ustanova` (`TIP_UST`, `TIP_NAZIV`) VALUES
	('A1', 'Akademija'),
	('F1', 'Fakultet'),
	('T1', 'Tip naziv'),
	('V1', 'Visoka skola');
/*!40000 ALTER TABLE `tipovi_ustanova` ENABLE KEYS */;

-- Dumping data for table projekat.tip_dokumentacije: ~0 rows (approximately)
/*!40000 ALTER TABLE `tip_dokumentacije` DISABLE KEYS */;
/*!40000 ALTER TABLE `tip_dokumentacije` ENABLE KEYS */;

-- Dumping data for table projekat.tip_kontakta: ~0 rows (approximately)
/*!40000 ALTER TABLE `tip_kontakta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tip_kontakta` ENABLE KEYS */;

-- Dumping data for table projekat.tip_programa: ~0 rows (approximately)
/*!40000 ALTER TABLE `tip_programa` DISABLE KEYS */;
/*!40000 ALTER TABLE `tip_programa` ENABLE KEYS */;

-- Dumping data for table projekat.uloga: ~0 rows (approximately)
/*!40000 ALTER TABLE `uloga` DISABLE KEYS */;
/*!40000 ALTER TABLE `uloga` ENABLE KEYS */;

-- Dumping data for table projekat.u_drzavi: ~0 rows (approximately)
/*!40000 ALTER TABLE `u_drzavi` DISABLE KEYS */;
/*!40000 ALTER TABLE `u_drzavi` ENABLE KEYS */;

-- Dumping data for table projekat.vidovi_nastave: ~4 rows (approximately)
/*!40000 ALTER TABLE `vidovi_nastave` DISABLE KEYS */;
INSERT INTO `vidovi_nastave` (`VID_VID`, `VID_NAZIV`) VALUES
	('1', 'Grupna'),
	('2', 'Kolektivna'),
	('3', 'Pojedinacna'),
	('v', 'Vid naziv');
/*!40000 ALTER TABLE `vidovi_nastave` ENABLE KEYS */;

-- Dumping data for table projekat.visokoskolska_ustanova: ~4 rows (approximately)
/*!40000 ALTER TABLE `visokoskolska_ustanova` DISABLE KEYS */;
INSERT INTO `visokoskolska_ustanova` (`TIP_UST`, `VU_IDENTIFIKATOR`, `VU_NAZIV`, `DR_IDENTIFIKATOR`, `VU_OSNOVANA`, `NM_IDENTIFIKATOR`, `VU_ADRESA`, `VU_WEB_ADRESA`, `VU_E_MAIL`, `VV_OZNAKA`, `VU_PIB`, `VU_MATICNI_BROJ`, `VU_GRB`, `VU_MEMORANDUM`) VALUES
	('A1', 10003, 'IT Akademija', 'SRB', '2006-01-01', 11000, 'ITA Adresa', 'ita.edu.rs', 'email@its.edu.rs', 'pr', '110002006', '01010092653', _binary 0x32303036, _binary 0x3131303031),
	('F1', 10002, 'Singidunum', 'SRB', '1999-01-01', 11000, 'Danijelova 32', 'singidunum.ac.rs', 'email@singimail.rs', 'pr', '110001999', '01019993456', _binary 0x31393939, _binary 0x3131303032),
	('T1', 1111, 'Vu naziv', 'DrI', '2020-01-16', 1111, 'adresa', 'web adres', 'email', 'vv', 'Vu pib', '02020020003', _binary 0x3232323232, _binary 0x3333333333),
	('V1', 10001, 'Visoka ETS', 'SRB', '1976-01-01', 11000, 'Adresa', 'viser.edu.rs', 'email@viser.edu.rs', 'dr', '110001389', '01019741252', _binary 0x31333839, _binary 0x3131303030);
/*!40000 ALTER TABLE `visokoskolska_ustanova` ENABLE KEYS */;

-- Dumping data for table projekat.vrsta_dokumenta: ~0 rows (approximately)
/*!40000 ALTER TABLE `vrsta_dokumenta` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrsta_dokumenta` ENABLE KEYS */;

-- Dumping data for table projekat.vrsta_radnog_odnosa: ~0 rows (approximately)
/*!40000 ALTER TABLE `vrsta_radnog_odnosa` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrsta_radnog_odnosa` ENABLE KEYS */;

-- Dumping data for table projekat.vrsta_srodstva: ~0 rows (approximately)
/*!40000 ALTER TABLE `vrsta_srodstva` DISABLE KEYS */;
/*!40000 ALTER TABLE `vrsta_srodstva` ENABLE KEYS */;

-- Dumping data for table projekat.vrsta_vlasnistva: ~3 rows (approximately)
/*!40000 ALTER TABLE `vrsta_vlasnistva` DISABLE KEYS */;
INSERT INTO `vrsta_vlasnistva` (`VV_OZNAKA`, `VV_NAZIV`) VALUES
	('dr', 'Drzava'),
	('pr', 'Privatna'),
	('vv', 'vv naziv');
/*!40000 ALTER TABLE `vrsta_vlasnistva` ENABLE KEYS */;

-- Dumping data for table projekat.za_oblasti_obrazovanja: ~0 rows (approximately)
/*!40000 ALTER TABLE `za_oblasti_obrazovanja` DISABLE KEYS */;
/*!40000 ALTER TABLE `za_oblasti_obrazovanja` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
