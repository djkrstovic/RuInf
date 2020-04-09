/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     11/13/2019 12:34:24 PM                       */
/*==============================================================*/


drop table if exists AKT_O_ORGANIZACIJI;

drop table if exists CLANOVI_PODORICE;

drop table if exists DODATNI_PODACI;

drop table if exists DOKUMENTI_O_ZAPOSLENIM;

drop table if exists DOKUMENTOVANJE_PREDMETA;

drop table if exists DOKUMENTOVANJE_PROGRAMA;

drop table if exists DOKUMENTOVANJE__AKREDITACIJE;

drop table if exists DOKUMENT_O_AKREDITACIJI;

drop table if exists DRZAVA;

drop table if exists FONDOVI_PO_KOMPETENCIJAMA;

drop table if exists FONDOVI_PO_VIDU;

drop table if exists GLAVNI_GRADOVI;

drop table if exists ISTORIJA_STAZA;

drop table if exists JEZICI;

drop table if exists KATEGORIJA_KOMPETENCIJE;

drop table if exists KOMPETENCIJE;

drop table if exists KONTAKT_PODACI;

drop table if exists LISTA_KOMPETENCIJA;

drop table if exists NASELJENO_MESTO;

drop table if exists NASTAVNI_PREDMETI;

drop table if exists NIVO_STUDIJA;

drop table if exists OBUHVAT_AKREDITACIJE;

drop table if exists ODGOVORNI_RUKOVODILAC;

drop table if exists ORGANIZACIJA_NASTAVE;

drop table if exists ORGANIZACIONA_SEMA;

drop table if exists ORGANIZACIONE_JEDINICE;

drop table if exists POVEZANE_KOMPETENCIJE;

drop table if exists POZICIJE_U_SEMI;

drop table if exists POZICIJE___FUNKCIJE;

drop table if exists PRAVNA_LICA;

drop table if exists RADNA_MESTA;

drop table if exists RASPOREDI_NA_RADNA_MESTA;

drop table if exists REGISTAR_GRUPA_OBRAZOVANJA;

drop table if exists REGISTAR_OBLASTI_OBRAZOVANJA;

drop table if exists REGISTAR_OBRAZOVNIH_POLJA;

drop table if exists REGISTAR_STRUCNIH_NAZIVA;

drop table if exists REGISTAR_ZAPOSLENIH;

drop table if exists REGISTROVANI_PROGRAMI;

drop table if exists RUKOVODNA_SEMA;

drop table if exists SASTAV_JEDINICE;

drop table if exists SASTAV_SLOZENE_USTANOVE;

drop table if exists SKOLPLENI_SA;

drop table if exists SLOZENA_DRZAVA;

drop table if exists SLUZBENI_JEZICI;

drop table if exists STEPEN_STUDIJA;

drop table if exists STRUKTURA_DOKUMENTACIJE;

drop table if exists STRUKTURA_PROGRAMA;

drop table if exists STRUKTURIRANE_KATEGORIJE;

drop table if exists STRUKTURIRANE_KOMPETENCIJE;

drop table if exists TIPOVI_USTANOVA;

drop table if exists TIP_DOKUMENTACIJE;

drop table if exists TIP_KONTAKTA;

drop table if exists TIP_PROGRAMA;

drop table if exists ULOGA;

drop table if exists U_DRZAVI;

drop table if exists VIDOVI_NASTAVE;

drop table if exists VISOKOSKOLSKA_USTANOVA;

drop table if exists VRSTA_DOKUMENTA;

drop table if exists VRSTA_RADNOG_ODNOSA;

drop table if exists VRSTA_SRODSTVA;

drop table if exists VRSTA_VLASNISTVA;

drop table if exists ZA_OBLASTI_OBRAZOVANJA;

/*==============================================================*/
/* Table: AKT_O_ORGANIZACIJI                                    */
/*==============================================================*/
create table AKT_O_ORGANIZACIJI
(
   TIP_UST              char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   AO_REDNI_BROJ        numeric(4,0) not null,
   OJ_IDENTIFIKATOR     int not null,
   AO_DATUM_DOKUMENTA   date not null,
   AO_VAZI_DO           date,
   primary key (TIP_UST, VU_IDENTIFIKATOR, AO_REDNI_BROJ)
);

/*==============================================================*/
/* Table: CLANOVI_PODORICE                                      */
/*==============================================================*/
create table CLANOVI_PODORICE
(
   TIP_UST              char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   ZAP_REDNI_BROJ       numeric(6,0) not null,
   RCP_REDNI_BROJ       numeric(2,0) not null,
   RCP_PREZIME          varchar(20),
   RCP_IME              varchar(20),
   RCP_JMBG             char(13),
   VSR_OZNAKA           char(2),
   primary key (TIP_UST, VU_IDENTIFIKATOR, ZAP_REDNI_BROJ, RCP_REDNI_BROJ)
);

/*==============================================================*/
/* Table: DODATNI_PODACI                                        */
/*==============================================================*/
create table DODATNI_PODACI
(
   TIP_UST              char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   ZAP_REDNI_BROJ       numeric(6,0) not null,
   RCP_REDNI_BROJ       numeric(2,0) not null,
   ULO_OZNAKA           char(2) not null,
   PL_OZNAKA            int not null,
   DOD_IDENT            smallint not null,
   DOD_OPIS             varchar(250),
   primary key (TIP_UST, VU_IDENTIFIKATOR, ZAP_REDNI_BROJ, ULO_OZNAKA, PL_OZNAKA, RCP_REDNI_BROJ, DOD_IDENT)
);

/*==============================================================*/
/* Table: DOKUMENTI_O_ZAPOSLENIM                                */
/*==============================================================*/
create table DOKUMENTI_O_ZAPOSLENIM
(
   TIP_UST              char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   VD_OZNAKA            char(2) not null,
   UG_GODINA            numeric(4,0) not null,
   UG_BROJ_DOKUMENTA    int not null,
   UG_DATIM             date not null,
   UG_DATUM_VAZENJA     date,
   primary key (TIP_UST, VU_IDENTIFIKATOR, VD_OZNAKA, UG_GODINA, UG_BROJ_DOKUMENTA)
);

/*==============================================================*/
/* Table: DOKUMENTOVANJE_PREDMETA                               */
/*==============================================================*/
create table DOKUMENTOVANJE_PREDMETA
(
   TIP_UST              char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   NP_PREDMET           varchar(6) not null,
   NP_VERZIJA           numeric(2,0) not null,
   JEZ_JERIK2           char(3) not null,
   OSNOVNI_DOKUMENT     char(2) not null,
   POVEZANI_DOKUMENT    char(2) not null,
   SDOK_NIVO            numeric(2,0) not null,
   DOKPR_DEO            numeric(2,0) not null,
   DOKPR_OPIS           varchar(1024),
   primary key (TIP_UST, VU_IDENTIFIKATOR, JEZ_JERIK2, OSNOVNI_DOKUMENT, POVEZANI_DOKUMENT, SDOK_NIVO, NP_PREDMET, NP_VERZIJA, DOKPR_DEO)
);

/*==============================================================*/
/* Table: DOKUMENTOVANJE_PROGRAMA                               */
/*==============================================================*/
create table DOKUMENTOVANJE_PROGRAMA
(
   TIP_UST              char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   TIPP_TIP             char(1) not null,
   SP_EVIDENCIONI_BROJ  int not null,
   SP_VERZIJA           numeric(2,0) not null,
   JEZ_JEZIK            char(3) not null,
   OSNOVNI_TIP_DOKUMENTA char(2) not null,
   POVEZANI_TIP_DOKUMENTA char(2) not null,
   SDOK_NIVO            numeric(2,0) not null,
   DOKPR_DEO_DOKUMENTACIJ numeric(2,0) not null,
   DOKPR_TEKST          varchar(1024),
   primary key (TIP_UST, VU_IDENTIFIKATOR, TIPP_TIP, JEZ_JEZIK, OSNOVNI_TIP_DOKUMENTA, POVEZANI_TIP_DOKUMENTA, SP_EVIDENCIONI_BROJ, SP_VERZIJA, SDOK_NIVO, DOKPR_DEO_DOKUMENTACIJ)
);

/*==============================================================*/
/* Table: DOKUMENTOVANJE__AKREDITACIJE                          */
/*==============================================================*/
create table DOKUMENTOVANJE__AKREDITACIJE
(
   TIP_UST              char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   AD_GODINA            numeric(4,0) not null,
   AD_EVIDENCIONI_BROJ  numeric(2,0) not null,
   AD_VERZIJA           numeric(2,0) not null,
   JEZ_JERIK2           char(3) not null,
   OSNOVNI_TIP_DOKUMENTA char(2) not null,
   POVEZANI_TIP_DOKUMENTA char(2) not null,
   SDOK_NIVO            numeric(2,0) not null,
   AKDOK_DEO            numeric(2,0) not null,
   AKDOK_OPIS           varchar(1024),
   primary key (TIP_UST, VU_IDENTIFIKATOR, JEZ_JERIK2, OSNOVNI_TIP_DOKUMENTA, POVEZANI_TIP_DOKUMENTA, AD_GODINA, AD_EVIDENCIONI_BROJ, AD_VERZIJA, SDOK_NIVO, AKDOK_DEO)
);

/*==============================================================*/
/* Table: DOKUMENT_O_AKREDITACIJI                               */
/*==============================================================*/
create table DOKUMENT_O_AKREDITACIJI
(
   TIP_UST              char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   AD_GODINA            numeric(4,0) not null,
   AD_EVIDENCIONI_BROJ  numeric(2,0) not null,
   AD_VERZIJA           numeric(2,0) not null,
   AD_DATUM_FORMIRANJA  date not null,
   primary key (TIP_UST, VU_IDENTIFIKATOR, AD_GODINA, AD_EVIDENCIONI_BROJ, AD_VERZIJA)
);

/*==============================================================*/
/* Table: DRZAVA                                                */
/*==============================================================*/
create table DRZAVA
(
   DR_IDENTIFIKATOR     char(3) not null,
   DR_NAZIV             varchar(80) not null,
   DR_DATUM_OSNIVANJA   date not null,
   DR_POSTOJALA_DO      date,
   DR_GRB               longblob,
   DR_ZASTAVA           longblob,
   DR_HIMNA             longblob,
   DRZ_DR_IDENTIFIKATOR char(3),
   primary key (DR_IDENTIFIKATOR)
);

/*==============================================================*/
/* Table: FONDOVI_PO_KOMPETENCIJAMA                             */
/*==============================================================*/
create table FONDOVI_PO_KOMPETENCIJAMA
(
   TIP_UST              char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   NP_PREDMET           varchar(6) not null,
   NP_VERZIJA           numeric(2,0) not null,
   VID_VID              char(1) not null,
   PO_POLJE             char(2) not null,
   GRU_GRUPA            char(2) not null,
   OBL_OBLAST           char(2) not null,
   KOMP_KATEGORIJA      char(2) not null,
   KO_KOMPETENCIJA      char(2) not null,
   KUP_U_FONDU_OD       numeric(2,0) not null default 0,
   primary key (TIP_UST, VU_IDENTIFIKATOR, NP_PREDMET, NP_VERZIJA, VID_VID, PO_POLJE, GRU_GRUPA, OBL_OBLAST, KOMP_KATEGORIJA, KO_KOMPETENCIJA)
);

/*==============================================================*/
/* Table: FONDOVI_PO_VIDU                                       */
/*==============================================================*/
create table FONDOVI_PO_VIDU
(
   TIP_UST              char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   NP_PREDMET           varchar(6) not null,
   NP_VERZIJA           numeric(2,0) not null,
   VID_VID              char(1) not null,
   FOND_UKUPNO_CASOVA   decimal(5,2) not null default 30,
   FOND_NACIN_IZVO_ENJA char(1) not null default 'K',
   primary key (TIP_UST, VU_IDENTIFIKATOR, NP_PREDMET, NP_VERZIJA, VID_VID)
);

/*==============================================================*/
/* Table: GLAVNI_GRADOVI                                        */
/*==============================================================*/
create table GLAVNI_GRADOVI
(
   DR_IDENTIFIKATOR     char(3) not null,
   NM_IDENTIFIKATOR     bigint not null,
   UDR_REDNI_BROJ       numeric(1,0) not null,
   primary key (NM_IDENTIFIKATOR, DR_IDENTIFIKATOR, UDR_REDNI_BROJ)
);

/*==============================================================*/
/* Table: ISTORIJA_STAZA                                        */
/*==============================================================*/
create table ISTORIJA_STAZA
(
   TIP_UST              char(2) not null,
   REG_VU_IDENTIFIKATOR int not null,
   ZAP_REDNI_BROJ       numeric(6,0) not null,
   PL_OZNAKA            int not null,
   IST_IDENT            smallint not null,
   RAD_TIP_UST          char(2),
   VU_IDENTIFIKATOR     int,
   RM_OZNAKA            char(3),
   VRO_OZNAKA           char(2) not null,
   IST_OD               date not null,
   IST_DO               date not null,
   IST_STAZ_GODINA      numeric(2,0) not null default 0,
   IST_STAZ_MESECI      numeric(2,0) not null default 0,
   IST_STAZ_DANA        numeric(2,0) not null default 0,
   primary key (TIP_UST, REG_VU_IDENTIFIKATOR, ZAP_REDNI_BROJ, PL_OZNAKA, IST_IDENT)
);

/*==============================================================*/
/* Table: JEZICI                                                */
/*==============================================================*/
create table JEZICI
(
   JEZ_JERIK2           char(3) not null,
   JEZ_NAZIV2           varchar(40) not null,
   primary key (JEZ_JERIK2)
);

/*==============================================================*/
/* Table: KATEGORIJA_KOMPETENCIJE                               */
/*==============================================================*/
create table KATEGORIJA_KOMPETENCIJE
(
   PO_POLJE             char(2) not null,
   GRU_GRUPA            char(2) not null,
   OBL_OBLAST           char(2) not null,
   KOMP_KATEGORIJA      char(2) not null,
   KOMP_NAZIV           varchar(120) not null,
   KOMP_OPIS            varchar(512),
   primary key (PO_POLJE, GRU_GRUPA, OBL_OBLAST, KOMP_KATEGORIJA)
);

/*==============================================================*/
/* Table: KOMPETENCIJE                                          */
/*==============================================================*/
create table KOMPETENCIJE
(
   PO_POLJE             char(2) not null,
   GRU_GRUPA            char(2) not null,
   OBL_OBLAST           char(2) not null,
   KOMP_KATEGORIJA      char(2) not null,
   KO_KOMPETENCIJA      char(2) not null,
   KO_NAZIV             varchar(120) not null,
   KO_OPIS              varchar(512),
   primary key (PO_POLJE, GRU_GRUPA, OBL_OBLAST, KOMP_KATEGORIJA, KO_KOMPETENCIJA)
);

/*==============================================================*/
/* Table: KONTAKT_PODACI                                        */
/*==============================================================*/
create table KONTAKT_PODACI
(
   TIP_UST              char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   ZAP_REDNI_BROJ       numeric(6,0) not null,
   TKO_OZNAKA           char(1) not null,
   KP_REDNI_BROJ        numeric(2,0) not null,
   NM_IDENTIFIKATOR     bigint,
   KP_ADRESA            varchar(80),
   KP_E_POSTA           varchar(60),
   KP_WWW               varchar(60),
   KP_KONTAKT_TELEFON   varchar(20),
   primary key (TIP_UST, VU_IDENTIFIKATOR, TKO_OZNAKA, ZAP_REDNI_BROJ, KP_REDNI_BROJ)
);

/*==============================================================*/
/* Table: LISTA_KOMPETENCIJA                                    */
/*==============================================================*/
create table LISTA_KOMPETENCIJA
(
   TIP_UST              char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   NP_PREDMET           varchar(6) not null,
   NP_VERZIJA           numeric(2,0) not null,
   PO_POLJE             char(2) not null,
   GRU_GRUPA            char(2) not null,
   OBL_OBLAST           char(2) not null,
   KOMP_KATEGORIJA      char(2) not null,
   KO_KOMPETENCIJA      char(2) not null,
   primary key (TIP_UST, PO_POLJE, GRU_GRUPA, OBL_OBLAST, KOMP_KATEGORIJA, VU_IDENTIFIKATOR, KO_KOMPETENCIJA, NP_PREDMET, NP_VERZIJA)
);

/*==============================================================*/
/* Table: NASELJENO_MESTO                                       */
/*==============================================================*/
create table NASELJENO_MESTO
(
   NM_IDENTIFIKATOR     bigint not null,
   NM_NAZIV             varchar(40) not null,
   primary key (NM_IDENTIFIKATOR)
);

/*==============================================================*/
/* Table: NASTAVNI_PREDMETI                                     */
/*==============================================================*/
create table NASTAVNI_PREDMETI
(
   TIP_UST              char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   NP_PREDMET           varchar(6) not null,
   NP_VERZIJA           numeric(2,0) not null,
   NP_NAZIV_PREDMETA    varchar(120) not null,
   NP_IZBORNA           bool not null default 0,
   primary key (TIP_UST, VU_IDENTIFIKATOR, NP_PREDMET, NP_VERZIJA)
);

/*==============================================================*/
/* Table: NIVO_STUDIJA                                          */
/*==============================================================*/
create table NIVO_STUDIJA
(
   STS_OZNAKA           char(2) not null,
   NS_NIVO              numeric(1,0) not null,
   NA_NAZIV             varchar(60) not null,
   SN_OZNAKA            char(2),
   primary key (STS_OZNAKA, NS_NIVO)
);

/*==============================================================*/
/* Table: OBUHVAT_AKREDITACIJE                                  */
/*==============================================================*/
create table OBUHVAT_AKREDITACIJE
(
   TIP_UST              char(2) not null,
   REG_VU_IDENTIFIKATOR int not null,
   AD_GODINA            numeric(4,0) not null,
   AD_EVIDENCIONI_BROJ  numeric(2,0) not null,
   AD_VERZIJA           numeric(2,0) not null,
   OAK_POZICIJA         numeric(3,0) not null,
   TIPP_TIP             char(1) not null,
   SP_EVIDENCIONI_BROJ  int not null,
   SP_VERZIJA           numeric(2,0) not null,
   OAK_STATUS           numeric(1,0) not null default 1,
   primary key (TIP_UST, REG_VU_IDENTIFIKATOR, AD_GODINA, AD_EVIDENCIONI_BROJ, AD_VERZIJA, OAK_POZICIJA)
);

/*==============================================================*/
/* Table: ODGOVORNI_RUKOVODILAC                                 */
/*==============================================================*/
create table ODGOVORNI_RUKOVODILAC
(
   TIP_UST              char(2) not null,
   REG_VU_IDENTIFIKATOR int not null,
   ZAP_REDNI_BROJ       numeric(6,0) not null,
   DOK_TIP_UST          char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   VD_OZNAKA            char(2) not null,
   UG_GODINA            numeric(4,0) not null,
   UG_BROJ_UGOVORA      int not null,
   primary key (DOK_TIP_UST, TIP_UST, REG_VU_IDENTIFIKATOR, VU_IDENTIFIKATOR, ZAP_REDNI_BROJ, VD_OZNAKA, UG_GODINA, UG_BROJ_UGOVORA)
);

/*==============================================================*/
/* Table: ORGANIZACIJA_NASTAVE                                  */
/*==============================================================*/
create table ORGANIZACIJA_NASTAVE
(
   ON_OZNAKA            char(1) not null,
   ON_NAZIV             varchar(20) not null,
   primary key (ON_OZNAKA)
);

/*==============================================================*/
/* Table: ORGANIZACIONA_SEMA                                    */
/*==============================================================*/
create table ORGANIZACIONA_SEMA
(
   TIP_UST              char(2) not null,
   AKT_VU_IDENTIFIKATOR int not null,
   AO_REDNI_BROJ        numeric(4,0) not null,
   OJ_IDENTIFIKATOR     int not null,
   primary key (TIP_UST, AKT_VU_IDENTIFIKATOR, AO_REDNI_BROJ, OJ_IDENTIFIKATOR)
);

/*==============================================================*/
/* Table: ORGANIZACIONE_JEDINICE                                */
/*==============================================================*/
create table ORGANIZACIONE_JEDINICE
(
   TIP_UST              char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   OJ_IDENTIFIKATOR     int not null,
   OJ_NAZIV             varchar(80) not null,
   NM_IDENTIFIKATOR     bigint not null,
   OJ_ADRESA            varchar(80),
   primary key (TIP_UST, VU_IDENTIFIKATOR, OJ_IDENTIFIKATOR)
);

/*==============================================================*/
/* Table: POVEZANE_KOMPETENCIJE                                 */
/*==============================================================*/
create table POVEZANE_KOMPETENCIJE
(
   TIP_UST              char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   TIPP_TIP             char(1) not null,
   SP_EVIDENCIONI_BROJ  int not null,
   SP_VERZIJA           numeric(2,0) not null,
   PO_POLJE             char(2) not null,
   GRU_GRUPA            char(2) not null,
   OBL_OBLAST           char(2) not null,
   KOMP_KATEGORIJA      char(2) not null,
   KO_KOMPETENCIJA      char(2) not null,
   primary key (TIP_UST, VU_IDENTIFIKATOR, PO_POLJE, GRU_GRUPA, OBL_OBLAST, KOMP_KATEGORIJA, TIPP_TIP, SP_EVIDENCIONI_BROJ, SP_VERZIJA, KO_KOMPETENCIJA)
);

/*==============================================================*/
/* Table: POZICIJE_U_SEMI                                       */
/*==============================================================*/
create table POZICIJE_U_SEMI
(
   VIS_TIP_UST          char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   RS_IDENTIFIKATOR     smallint not null,
   POZ_OZNAKA           char(2) not null,
   primary key (VIS_TIP_UST, VU_IDENTIFIKATOR, POZ_OZNAKA, RS_IDENTIFIKATOR)
);

/*==============================================================*/
/* Table: POZICIJE___FUNKCIJE                                   */
/*==============================================================*/
create table POZICIJE___FUNKCIJE
(
   POZ_OZNAKA           char(2) not null,
   POZ_NAZIV            varchar(60) not null,
   primary key (POZ_OZNAKA)
);

/*==============================================================*/
/* Table: PRAVNA_LICA                                           */
/*==============================================================*/
create table PRAVNA_LICA
(
   PL_OZNAKA            int not null,
   PL_NAZIV             varchar(120) not null,
   primary key (PL_OZNAKA)
);

/*==============================================================*/
/* Table: RADNA_MESTA                                           */
/*==============================================================*/
create table RADNA_MESTA
(
   TIP_UST              char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   RM_OZNAKA            char(3) not null,
   RM_NAZIV             varchar(50) not null,
   RM_OPERATIVNO        bool,
   primary key (TIP_UST, VU_IDENTIFIKATOR, RM_OZNAKA)
);

/*==============================================================*/
/* Table: RASPOREDI_NA_RADNA_MESTA                              */
/*==============================================================*/
create table RASPOREDI_NA_RADNA_MESTA
(
   REG_TIP_UST          char(2) not null,
   REG_VU_IDENTIFIKATOR int not null,
   ZAP_REDNI_BROJ       numeric(6,0) not null,
   RAS_RBR              numeric(4,0) not null,
   VRO_OZNAKA           char(2),
   RM_OZNAKA            char(3) not null,
   OJ_IDENTIFIKATOR     int not null,
   RAS_ODKADA           date not null,
   RAS_DO_KADA          date,
   primary key (REG_TIP_UST, REG_VU_IDENTIFIKATOR, ZAP_REDNI_BROJ, RAS_RBR)
);

/*==============================================================*/
/* Table: REGISTAR_GRUPA_OBRAZOVANJA                            */
/*==============================================================*/
create table REGISTAR_GRUPA_OBRAZOVANJA
(
   PO_POLJE             char(2) not null,
   GRU_GRUPA            char(2) not null,
   GRU_NAZIV            varchar(120) not null,
   primary key (PO_POLJE, GRU_GRUPA)
);

/*==============================================================*/
/* Table: REGISTAR_OBLASTI_OBRAZOVANJA                          */
/*==============================================================*/
create table REGISTAR_OBLASTI_OBRAZOVANJA
(
   PO_POLJE             char(2) not null,
   GRU_GRUPA            char(2) not null,
   OBL_OBLAST           char(2) not null,
   OBL_NAZIV            varchar(120) not null,
   OBL_KORPUS           bool not null default 0,
   primary key (PO_POLJE, GRU_GRUPA, OBL_OBLAST)
);

/*==============================================================*/
/* Table: REGISTAR_OBRAZOVNIH_POLJA                             */
/*==============================================================*/
create table REGISTAR_OBRAZOVNIH_POLJA
(
   PO_POLJE             char(2) not null,
   PO_NAZIV             varchar(120) not null,
   primary key (PO_POLJE)
);

/*==============================================================*/
/* Table: REGISTAR_STRUCNIH_NAZIVA                              */
/*==============================================================*/
create table REGISTAR_STRUCNIH_NAZIVA
(
   SN_OZNAKA            char(2) not null,
   SN_STRUCNI_NAZIV     varchar(120) not null,
   SN_SKRACENI_NAZIV    varchar(12) not null,
   primary key (SN_OZNAKA)
);

/*==============================================================*/
/* Table: REGISTAR_ZAPOSLENIH                                   */
/*==============================================================*/
create table REGISTAR_ZAPOSLENIH
(
   TIP_UST              char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   ZAP_REDNI_BROJ       numeric(6,0) not null,
   ZAP_PREZIME          varchar(20) not null,
   ZAP_SREDNJE_SLOVO    char(2) not null,
   ZAP_IME              varchar(20) not null,
   ZAP_FOTOGRAFIJA      longblob,
   ZAP_JMBG             char(13),
   RCP_REDNI_BROJ       numeric(2,0),
   CLA_ZAP_REDNI_BROJ   numeric(6,0),
   primary key (TIP_UST, VU_IDENTIFIKATOR, ZAP_REDNI_BROJ)
);

/*==============================================================*/
/* Table: REGISTROVANI_PROGRAMI                                 */
/*==============================================================*/
create table REGISTROVANI_PROGRAMI
(
   TIP_UST              char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   TIPP_TIP             char(1) not null,
   SP_EVIDENCIONI_BROJ  int not null,
   SP_VERZIJA           numeric(2,0) not null,
   SP_NAZIV             varchar(60) not null,
   STS_OZNAKA           char(2) not null,
   NS_NIVO              numeric(1,0) not null,
   JEZ_JERIK2           char(3) not null,
   SN_OZNAKA            char(2) not null,
   SP_DATUM_FORMIRANJA  date not null,
   SP_DATUM_UKIDANJA    date,
   primary key (TIP_UST, VU_IDENTIFIKATOR, TIPP_TIP, SP_EVIDENCIONI_BROJ, SP_VERZIJA)
);

/*==============================================================*/
/* Table: RUKOVODNA_SEMA                                        */
/*==============================================================*/
create table RUKOVODNA_SEMA
(
   VIS_TIP_UST          char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   RS_IDENTIFIKATOR     smallint not null,
   RS_DATUM_FORMIRANJA  date not null,
   OJ_IDENTIFIKATOR     int not null,
   primary key (VIS_TIP_UST, VU_IDENTIFIKATOR, RS_IDENTIFIKATOR)
);

/*==============================================================*/
/* Table: SASTAV_JEDINICE                                       */
/*==============================================================*/
create table SASTAV_JEDINICE
(
   ORG_TIP_UST          char(2) not null,
   ORG_VU_IDENTIFIKATOR int not null,
   ORG_OJ_IDENTIFIKATOR int not null,
   OJ_IDENTIFIKATOR     int not null,
   primary key (ORG_TIP_UST, ORG_VU_IDENTIFIKATOR, OJ_IDENTIFIKATOR, ORG_OJ_IDENTIFIKATOR)
);

/*==============================================================*/
/* Table: SASTAV_SLOZENE_USTANOVE                               */
/*==============================================================*/
create table SASTAV_SLOZENE_USTANOVE
(
   TIP_UST              char(2) not null,
   AKT_VU_IDENTIFIKATOR int not null,
   AO_REDNI_BROJ        numeric(4,0) not null,
   VIS_TIP_UST          char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   primary key (VIS_TIP_UST, TIP_UST, AKT_VU_IDENTIFIKATOR, AO_REDNI_BROJ, VU_IDENTIFIKATOR)
);

/*==============================================================*/
/* Table: SKOLPLENI_SA                                          */
/*==============================================================*/
create table SKOLPLENI_SA
(
   DOK_TIP_UST          char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   VD_OZNAKA            char(2) not null,
   UG_GODINA            numeric(4,0) not null,
   UG_BROJ_UGOVORA      int not null,
   TIP_UST              char(2) not null,
   REG_VU_IDENTIFIKATOR int not null,
   ZAP_REDNI_BROJ       numeric(6,0) not null,
   primary key (DOK_TIP_UST, TIP_UST, REG_VU_IDENTIFIKATOR, VU_IDENTIFIKATOR, VD_OZNAKA, UG_GODINA, UG_BROJ_UGOVORA, ZAP_REDNI_BROJ)
);

/*==============================================================*/
/* Table: SLOZENA_DRZAVA                                        */
/*==============================================================*/
create table SLOZENA_DRZAVA
(
   DR_IDENTIFIKATOR     char(3) not null,
   DRZ_DR_IDENTIFIKATOR char(3) not null,
   primary key (DR_IDENTIFIKATOR, DRZ_DR_IDENTIFIKATOR)
);

/*==============================================================*/
/* Table: SLUZBENI_JEZICI                                       */
/*==============================================================*/
create table SLUZBENI_JEZICI
(
   JEZ_JERIK2           char(3) not null,
   DR_IDENTIFIKATOR     char(3) not null,
   primary key (JEZ_JERIK2, DR_IDENTIFIKATOR)
);

/*==============================================================*/
/* Table: STEPEN_STUDIJA                                        */
/*==============================================================*/
create table STEPEN_STUDIJA
(
   STS_OZNAKA           char(2) not null,
   STS_NAZIV            varchar(40) not null,
   primary key (STS_OZNAKA)
);

/*==============================================================*/
/* Table: STRUKTURA_DOKUMENTACIJE                               */
/*==============================================================*/
create table STRUKTURA_DOKUMENTACIJE
(
   JEZ_JERIK2           char(3) not null,
   OSNOVNI_TIP_DOKUMENTA char(2) not null,
   SDOK_NIVO            numeric(2,0) not null,
   SADRZANI_TIP_DOKUMENTA char(2) not null,
   SDOK_NAZIV           varchar(120) not null,
   primary key (JEZ_JERIK2, OSNOVNI_TIP_DOKUMENTA, SADRZANI_TIP_DOKUMENTA, SDOK_NIVO)
);

/*==============================================================*/
/* Table: STRUKTURA_PROGRAMA                                    */
/*==============================================================*/
create table STRUKTURA_PROGRAMA
(
   TIP_UST              char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   TIPP_TIP             char(1) not null,
   SP_EVIDENCIONI_BROJ  int not null,
   SP_VERZIJA           numeric(2,0) not null,
   ON_OZNAKA            char(1) not null,
   BLOKN_REDNI_BROJ     numeric(2,0) not null,
   BLOKN_TRAJE          numeric(2,0) not null default 1,
   primary key (TIP_UST, VU_IDENTIFIKATOR, TIPP_TIP, SP_EVIDENCIONI_BROJ, SP_VERZIJA, ON_OZNAKA, BLOKN_REDNI_BROJ)
);

/*==============================================================*/
/* Table: STRUKTURIRANE_KATEGORIJE                              */
/*==============================================================*/
create table STRUKTURIRANE_KATEGORIJE
(
   PO_POLJE             char(2) not null,
   GRU_GRUPA            char(2) not null,
   OBL_OBLAST           char(2) not null,
   KOMP_KATEGORIJA      char(2) not null,
   KAT_KOMP_KATEGORIJA  char(2) not null,
   primary key (PO_POLJE, GRU_GRUPA, OBL_OBLAST, KOMP_KATEGORIJA, KAT_KOMP_KATEGORIJA)
);

/*==============================================================*/
/* Table: STRUKTURIRANE_KOMPETENCIJE                            */
/*==============================================================*/
create table STRUKTURIRANE_KOMPETENCIJE
(
   PO_POLJE             char(2) not null,
   GRU_GRUPA            char(2) not null,
   OBL_OBLAST           char(2) not null,
   KOMP_KATEGORIJA      char(2) not null,
   KO_KOMPETENCIJA      char(2) not null,
   KOM_KO_KOMPETENCIJA  char(2) not null,
   primary key (PO_POLJE, GRU_GRUPA, OBL_OBLAST, KOMP_KATEGORIJA, KO_KOMPETENCIJA, KOM_KO_KOMPETENCIJA)
);

/*==============================================================*/
/* Table: TIPOVI_USTANOVA                                       */
/*==============================================================*/
create table TIPOVI_USTANOVA
(
   TIP_UST              char(2) not null,
   TIP_NAZIV            varchar(40) not null,
   primary key (TIP_UST)
);

/*==============================================================*/
/* Table: TIP_DOKUMENTACIJE                                     */
/*==============================================================*/
create table TIP_DOKUMENTACIJE
(
   JEZ_JERIK2           char(3) not null,
   TIP_DOKUMENTA        char(2) not null,
   TIP_NAZIV_TIPA       varchar(60) not null,
   primary key (JEZ_JERIK2, TIP_DOKUMENTA)
);

/*==============================================================*/
/* Table: TIP_KONTAKTA                                          */
/*==============================================================*/
create table TIP_KONTAKTA
(
   TKO_OZNAKA           char(1) not null,
   TKO_NAZIV            varchar(30) not null,
   primary key (TKO_OZNAKA)
);

/*==============================================================*/
/* Table: TIP_PROGRAMA                                          */
/*==============================================================*/
create table TIP_PROGRAMA
(
   TIPP_TIP             char(1) not null,
   TIPP_NAZIV           varchar(40) not null,
   primary key (TIPP_TIP)
);

/*==============================================================*/
/* Table: ULOGA                                                 */
/*==============================================================*/
create table ULOGA
(
   ULO_OZNAKA           char(2) not null,
   ULO_NAZIV            varchar(40) not null,
   primary key (ULO_OZNAKA)
);

/*==============================================================*/
/* Table: U_DRZAVI                                              */
/*==============================================================*/
create table U_DRZAVI
(
   DR_IDENTIFIKATOR     char(3) not null,
   NM_IDENTIFIKATOR     bigint not null,
   UDR_REDNI_BROJ       numeric(1,0) not null,
   OD_DATUMA            date,
   DO_DATUMA            date,
   primary key (DR_IDENTIFIKATOR, NM_IDENTIFIKATOR, UDR_REDNI_BROJ)
);

/*==============================================================*/
/* Table: VIDOVI_NASTAVE                                        */
/*==============================================================*/
create table VIDOVI_NASTAVE
(
   VID_VID              char(1) not null,
   VID_NAZIV            varchar(40) not null,
   primary key (VID_VID)
);

/*==============================================================*/
/* Table: VISOKOSKOLSKA_USTANOVA                                */
/*==============================================================*/
create table VISOKOSKOLSKA_USTANOVA
(
   TIP_UST              char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   VU_NAZIV             varchar(120),
   DR_IDENTIFIKATOR     char(3) not null,
   VU_OSNOVANA          date,
   NM_IDENTIFIKATOR     bigint,
   VU_ADRESA            varchar(60),
   VU_WEB_ADRESA        varchar(80),
   VU_E_MAIL            varchar(60),
   VV_OZNAKA            char(2) not null,
   VU_PIB               char(10),
   VU_MATICNI_BROJ      char(11),
   VU_GRB               longblob,
   VU_MEMORANDUM        longblob,
   primary key (TIP_UST, VU_IDENTIFIKATOR)
);

/*==============================================================*/
/* Table: VRSTA_DOKUMENTA                                       */
/*==============================================================*/
create table VRSTA_DOKUMENTA
(
   VD_OZNAKA            char(2) not null,
   VD_NAZIV             varchar(40) not null,
   primary key (VD_OZNAKA)
);

/*==============================================================*/
/* Table: VRSTA_RADNOG_ODNOSA                                   */
/*==============================================================*/
create table VRSTA_RADNOG_ODNOSA
(
   VRO_OZNAKA           char(2) not null,
   VRO_NAZIV            varchar(40) not null,
   primary key (VRO_OZNAKA)
);

/*==============================================================*/
/* Table: VRSTA_SRODSTVA                                        */
/*==============================================================*/
create table VRSTA_SRODSTVA
(
   VSR_OZNAKA           char(2) not null,
   VSR_NAZIV            varchar(30) not null,
   primary key (VSR_OZNAKA)
);

/*==============================================================*/
/* Table: VRSTA_VLASNISTVA                                      */
/*==============================================================*/
create table VRSTA_VLASNISTVA
(
   VV_OZNAKA            char(2) not null,
   VV_NAZIV             varchar(40) not null,
   primary key (VV_OZNAKA)
);

/*==============================================================*/
/* Table: ZA_OBLASTI_OBRAZOVANJA                                */
/*==============================================================*/
create table ZA_OBLASTI_OBRAZOVANJA
(
   TIP_UST              char(2) not null,
   VU_IDENTIFIKATOR     int not null,
   TIPP_TIP             char(1) not null,
   SP_EVIDENCIONI_BROJ  int not null,
   SP_VERZIJA           numeric(2,0) not null,
   PO_POLJE             char(2) not null,
   GRU_GRUPA            char(2) not null,
   OBL_OBLAST           char(2) not null,
   primary key (TIP_UST, VU_IDENTIFIKATOR, PO_POLJE, GRU_GRUPA, OBL_OBLAST, TIPP_TIP, SP_EVIDENCIONI_BROJ, SP_VERZIJA)
);

alter table AKT_O_ORGANIZACIJI add constraint FK_DOKUMENT_O_ORGANIZACIJI foreign key (TIP_UST, VU_IDENTIFIKATOR)
      references VISOKOSKOLSKA_USTANOVA (TIP_UST, VU_IDENTIFIKATOR) on delete restrict on update restrict;

alter table AKT_O_ORGANIZACIJI add constraint FK_DONEO_ORGAN foreign key (TIP_UST, VU_IDENTIFIKATOR, OJ_IDENTIFIKATOR)
      references ORGANIZACIONE_JEDINICE (TIP_UST, VU_IDENTIFIKATOR, OJ_IDENTIFIKATOR) on delete restrict on update restrict;

alter table CLANOVI_PODORICE add constraint FK_RELATIONSHIP_18 foreign key (TIP_UST, VU_IDENTIFIKATOR, ZAP_REDNI_BROJ)
      references REGISTAR_ZAPOSLENIH (TIP_UST, VU_IDENTIFIKATOR, ZAP_REDNI_BROJ) on delete restrict on update restrict;

alter table CLANOVI_PODORICE add constraint FK_U_SRODSTVU foreign key (VSR_OZNAKA)
      references VRSTA_SRODSTVA (VSR_OZNAKA) on delete restrict on update restrict;

alter table DODATNI_PODACI add constraint FK_PREMA_PRAVNOM_LICU foreign key (PL_OZNAKA)
      references PRAVNA_LICA (PL_OZNAKA) on delete restrict on update restrict;

alter table DODATNI_PODACI add constraint FK_ULOGE_CLANA foreign key (TIP_UST, VU_IDENTIFIKATOR, ZAP_REDNI_BROJ, RCP_REDNI_BROJ)
      references CLANOVI_PODORICE (TIP_UST, VU_IDENTIFIKATOR, ZAP_REDNI_BROJ, RCP_REDNI_BROJ) on delete restrict on update restrict;

alter table DODATNI_PODACI add constraint FK_U_ULOZI foreign key (ULO_OZNAKA)
      references ULOGA (ULO_OZNAKA) on delete restrict on update restrict;

alter table DOKUMENTI_O_ZAPOSLENIM add constraint FK_KLASIFIKACIJA_DOKUMENTA foreign key (VD_OZNAKA)
      references VRSTA_DOKUMENTA (VD_OZNAKA) on delete restrict on update restrict;

alter table DOKUMENTI_O_ZAPOSLENIM add constraint FK_PROTOKOL_UGOVORA foreign key (TIP_UST, VU_IDENTIFIKATOR)
      references VISOKOSKOLSKA_USTANOVA (TIP_UST, VU_IDENTIFIKATOR) on delete restrict on update restrict;

alter table DOKUMENTOVANJE_PREDMETA add constraint FK_DOKUMENTACIJA_ZA_PREDMET foreign key (JEZ_JERIK2, OSNOVNI_DOKUMENT, POVEZANI_DOKUMENT, SDOK_NIVO)
      references STRUKTURA_DOKUMENTACIJE (JEZ_JERIK2, OSNOVNI_TIP_DOKUMENTA, SADRZANI_TIP_DOKUMENTA, SDOK_NIVO) on delete restrict on update restrict;

alter table DOKUMENTOVANJE_PREDMETA add constraint FK_PRATECA_DOKUMENTACIJA foreign key (TIP_UST, VU_IDENTIFIKATOR, NP_PREDMET, NP_VERZIJA)
      references NASTAVNI_PREDMETI (TIP_UST, VU_IDENTIFIKATOR, NP_PREDMET, NP_VERZIJA) on delete restrict on update restrict;

alter table DOKUMENTOVANJE_PROGRAMA add constraint FK_DOKUMENTACIJA_ZA_PROGRAM foreign key (JEZ_JEZIK, OSNOVNI_TIP_DOKUMENTA, POVEZANI_TIP_DOKUMENTA, SDOK_NIVO)
      references STRUKTURA_DOKUMENTACIJE (JEZ_JERIK2, OSNOVNI_TIP_DOKUMENTA, SADRZANI_TIP_DOKUMENTA, SDOK_NIVO) on delete restrict on update restrict;

alter table DOKUMENTOVANJE_PROGRAMA add constraint FK_PROGRAM_DOKUMENTACIJA foreign key (TIP_UST, VU_IDENTIFIKATOR, TIPP_TIP, SP_EVIDENCIONI_BROJ, SP_VERZIJA)
      references REGISTROVANI_PROGRAMI (TIP_UST, VU_IDENTIFIKATOR, TIPP_TIP, SP_EVIDENCIONI_BROJ, SP_VERZIJA) on delete restrict on update restrict;

alter table DOKUMENTOVANJE__AKREDITACIJE add constraint FK_DOKUMENTACIJA_ZA_AKREDITACIJU foreign key (JEZ_JERIK2, OSNOVNI_TIP_DOKUMENTA, POVEZANI_TIP_DOKUMENTA, SDOK_NIVO)
      references STRUKTURA_DOKUMENTACIJE (JEZ_JERIK2, OSNOVNI_TIP_DOKUMENTA, SADRZANI_TIP_DOKUMENTA, SDOK_NIVO) on delete restrict on update restrict;

alter table DOKUMENTOVANJE__AKREDITACIJE add constraint FK_PREAMBULE_DOKUMENATA foreign key (TIP_UST, VU_IDENTIFIKATOR, AD_GODINA, AD_EVIDENCIONI_BROJ, AD_VERZIJA)
      references DOKUMENT_O_AKREDITACIJI (TIP_UST, VU_IDENTIFIKATOR, AD_GODINA, AD_EVIDENCIONI_BROJ, AD_VERZIJA) on delete restrict on update restrict;

alter table DOKUMENT_O_AKREDITACIJI add constraint FK_DOKUMENTI_AKREDITACIJE foreign key (TIP_UST, VU_IDENTIFIKATOR)
      references VISOKOSKOLSKA_USTANOVA (TIP_UST, VU_IDENTIFIKATOR) on delete restrict on update restrict;

alter table DRZAVA add constraint FK_PRAVNI_NASLEDNIK foreign key (DRZ_DR_IDENTIFIKATOR)
      references DRZAVA (DR_IDENTIFIKATOR) on delete restrict on update restrict;

alter table FONDOVI_PO_KOMPETENCIJAMA add constraint FK_KMPETENCIJA_U_FONDU_PREDMETU foreign key (PO_POLJE, GRU_GRUPA, OBL_OBLAST, KOMP_KATEGORIJA, KO_KOMPETENCIJA)
      references KOMPETENCIJE (PO_POLJE, GRU_GRUPA, OBL_OBLAST, KOMP_KATEGORIJA, KO_KOMPETENCIJA) on delete restrict on update restrict;

alter table FONDOVI_PO_KOMPETENCIJAMA add constraint FK_PO_KOMPETENCIJAMA foreign key (TIP_UST, VU_IDENTIFIKATOR, NP_PREDMET, NP_VERZIJA, VID_VID)
      references FONDOVI_PO_VIDU (TIP_UST, VU_IDENTIFIKATOR, NP_PREDMET, NP_VERZIJA, VID_VID) on delete restrict on update restrict;

alter table FONDOVI_PO_VIDU add constraint FK_FOND_NASTAVE foreign key (TIP_UST, VU_IDENTIFIKATOR, NP_PREDMET, NP_VERZIJA)
      references NASTAVNI_PREDMETI (TIP_UST, VU_IDENTIFIKATOR, NP_PREDMET, NP_VERZIJA) on delete restrict on update restrict;

alter table FONDOVI_PO_VIDU add constraint FK_VID_FONDA foreign key (VID_VID)
      references VIDOVI_NASTAVE (VID_VID) on delete restrict on update restrict;

alter table GLAVNI_GRADOVI add constraint FK_GLAVNI_GRADOVI foreign key (DR_IDENTIFIKATOR)
      references DRZAVA (DR_IDENTIFIKATOR) on delete restrict on update restrict;

alter table GLAVNI_GRADOVI add constraint FK_GLAVNI_GRADOVI2 foreign key (DR_IDENTIFIKATOR, NM_IDENTIFIKATOR, UDR_REDNI_BROJ)
      references U_DRZAVI (DR_IDENTIFIKATOR, NM_IDENTIFIKATOR, UDR_REDNI_BROJ) on delete restrict on update restrict;

alter table ISTORIJA_STAZA add constraint FK_AFFILIATION foreign key (TIP_UST, REG_VU_IDENTIFIKATOR, ZAP_REDNI_BROJ)
      references REGISTAR_ZAPOSLENIH (TIP_UST, VU_IDENTIFIKATOR, ZAP_REDNI_BROJ) on delete restrict on update restrict;

alter table ISTORIJA_STAZA add constraint FK_NA_POSLOVIMA foreign key (RAD_TIP_UST, VU_IDENTIFIKATOR, RM_OZNAKA)
      references RADNA_MESTA (TIP_UST, VU_IDENTIFIKATOR, RM_OZNAKA) on delete restrict on update restrict;

alter table ISTORIJA_STAZA add constraint FK_RADILI_KOD foreign key (PL_OZNAKA)
      references PRAVNA_LICA (PL_OZNAKA) on delete restrict on update restrict;

alter table ISTORIJA_STAZA add constraint FK_VRSTA_RO foreign key (VRO_OZNAKA)
      references VRSTA_RADNOG_ODNOSA (VRO_OZNAKA) on delete restrict on update restrict;

alter table KATEGORIJA_KOMPETENCIJE add constraint FK_KATEGORIZIRANE_KOMPETENCIJE foreign key (PO_POLJE, GRU_GRUPA, OBL_OBLAST)
      references REGISTAR_OBLASTI_OBRAZOVANJA (PO_POLJE, GRU_GRUPA, OBL_OBLAST) on delete restrict on update restrict;

alter table KOMPETENCIJE add constraint FK_KOMPETENCIJE foreign key (PO_POLJE, GRU_GRUPA, OBL_OBLAST, KOMP_KATEGORIJA)
      references KATEGORIJA_KOMPETENCIJE (PO_POLJE, GRU_GRUPA, OBL_OBLAST, KOMP_KATEGORIJA) on delete restrict on update restrict;

alter table KONTAKT_PODACI add constraint FK_KONTAKTIRA_SE foreign key (TIP_UST, VU_IDENTIFIKATOR, ZAP_REDNI_BROJ)
      references REGISTAR_ZAPOSLENIH (TIP_UST, VU_IDENTIFIKATOR, ZAP_REDNI_BROJ) on delete restrict on update restrict;

alter table KONTAKT_PODACI add constraint FK_MESTO_KONTAKTA foreign key (NM_IDENTIFIKATOR)
      references NASELJENO_MESTO (NM_IDENTIFIKATOR) on delete restrict on update restrict;

alter table KONTAKT_PODACI add constraint FK_U_KONTAKTU_SA foreign key (TKO_OZNAKA)
      references TIP_KONTAKTA (TKO_OZNAKA) on delete restrict on update restrict;

alter table LISTA_KOMPETENCIJA add constraint FK_LISTA_KOMPETENCIJA foreign key (PO_POLJE, GRU_GRUPA, OBL_OBLAST, KOMP_KATEGORIJA, KO_KOMPETENCIJA)
      references KOMPETENCIJE (PO_POLJE, GRU_GRUPA, OBL_OBLAST, KOMP_KATEGORIJA, KO_KOMPETENCIJA) on delete restrict on update restrict;

alter table LISTA_KOMPETENCIJA add constraint FK_LISTA_KOMPETENCIJA2 foreign key (TIP_UST, VU_IDENTIFIKATOR, NP_PREDMET, NP_VERZIJA)
      references NASTAVNI_PREDMETI (TIP_UST, VU_IDENTIFIKATOR, NP_PREDMET, NP_VERZIJA) on delete restrict on update restrict;

alter table NASTAVNI_PREDMETI add constraint FK_NUDI_PREDMETE foreign key (TIP_UST, VU_IDENTIFIKATOR)
      references VISOKOSKOLSKA_USTANOVA (TIP_UST, VU_IDENTIFIKATOR) on delete restrict on update restrict;

alter table NIVO_STUDIJA add constraint FK_NAZIV_ZA_NIVO foreign key (SN_OZNAKA)
      references REGISTAR_STRUCNIH_NAZIVA (SN_OZNAKA) on delete restrict on update restrict;

alter table NIVO_STUDIJA add constraint FK_PO_NIVOIMA foreign key (STS_OZNAKA)
      references STEPEN_STUDIJA (STS_OZNAKA) on delete restrict on update restrict;

alter table OBUHVAT_AKREDITACIJE add constraint FK_PROGRAMI_U_DOKUMENTU foreign key (TIP_UST, REG_VU_IDENTIFIKATOR, AD_GODINA, AD_EVIDENCIONI_BROJ, AD_VERZIJA)
      references DOKUMENT_O_AKREDITACIJI (TIP_UST, VU_IDENTIFIKATOR, AD_GODINA, AD_EVIDENCIONI_BROJ, AD_VERZIJA) on delete restrict on update restrict;

alter table OBUHVAT_AKREDITACIJE add constraint FK_PROGRAM_U_OBUHVATU foreign key (TIP_UST, REG_VU_IDENTIFIKATOR, TIPP_TIP, SP_EVIDENCIONI_BROJ, SP_VERZIJA)
      references REGISTROVANI_PROGRAMI (TIP_UST, VU_IDENTIFIKATOR, TIPP_TIP, SP_EVIDENCIONI_BROJ, SP_VERZIJA) on delete restrict on update restrict;

alter table ODGOVORNI_RUKOVODILAC add constraint FK_ODGOVORNI_RUKOVODILAC foreign key (TIP_UST, REG_VU_IDENTIFIKATOR, ZAP_REDNI_BROJ)
      references REGISTAR_ZAPOSLENIH (TIP_UST, VU_IDENTIFIKATOR, ZAP_REDNI_BROJ) on delete restrict on update restrict;

alter table ODGOVORNI_RUKOVODILAC add constraint FK_ODGOVORNI_RUKOVODILAC2 foreign key (DOK_TIP_UST, VU_IDENTIFIKATOR, VD_OZNAKA, UG_GODINA, UG_BROJ_UGOVORA)
      references DOKUMENTI_O_ZAPOSLENIM (TIP_UST, VU_IDENTIFIKATOR, VD_OZNAKA, UG_GODINA, UG_BROJ_DOKUMENTA) on delete restrict on update restrict;

alter table ORGANIZACIONA_SEMA add constraint FK_ORGANIZACIONA_SEMA foreign key (TIP_UST, AKT_VU_IDENTIFIKATOR, AO_REDNI_BROJ)
      references AKT_O_ORGANIZACIJI (TIP_UST, VU_IDENTIFIKATOR, AO_REDNI_BROJ) on delete restrict on update restrict;

alter table ORGANIZACIONA_SEMA add constraint FK_ORGANIZACIONA_SEMA2 foreign key (TIP_UST, AKT_VU_IDENTIFIKATOR, OJ_IDENTIFIKATOR)
      references ORGANIZACIONE_JEDINICE (TIP_UST, VU_IDENTIFIKATOR, OJ_IDENTIFIKATOR) on delete restrict on update restrict;

alter table ORGANIZACIONE_JEDINICE add constraint FK_SEDISTE_JEDINICE foreign key (NM_IDENTIFIKATOR)
      references NASELJENO_MESTO (NM_IDENTIFIKATOR) on delete restrict on update restrict;

alter table ORGANIZACIONE_JEDINICE add constraint FK_UNUTRASNJA_ORGANIZACIJA foreign key (TIP_UST, VU_IDENTIFIKATOR)
      references VISOKOSKOLSKA_USTANOVA (TIP_UST, VU_IDENTIFIKATOR) on delete restrict on update restrict;

alter table POVEZANE_KOMPETENCIJE add constraint FK_POVEZANE_KOMPETENCIJE foreign key (TIP_UST, VU_IDENTIFIKATOR, TIPP_TIP, SP_EVIDENCIONI_BROJ, SP_VERZIJA)
      references REGISTROVANI_PROGRAMI (TIP_UST, VU_IDENTIFIKATOR, TIPP_TIP, SP_EVIDENCIONI_BROJ, SP_VERZIJA) on delete restrict on update restrict;

alter table POVEZANE_KOMPETENCIJE add constraint FK_POVEZANE_KOMPETENCIJE2 foreign key (PO_POLJE, GRU_GRUPA, OBL_OBLAST, KOMP_KATEGORIJA, KO_KOMPETENCIJA)
      references KOMPETENCIJE (PO_POLJE, GRU_GRUPA, OBL_OBLAST, KOMP_KATEGORIJA, KO_KOMPETENCIJA) on delete restrict on update restrict;

alter table POZICIJE_U_SEMI add constraint FK_POZICIJE_U_SEMI foreign key (POZ_OZNAKA)
      references POZICIJE___FUNKCIJE (POZ_OZNAKA) on delete restrict on update restrict;

alter table POZICIJE_U_SEMI add constraint FK_POZICIJE_U_SEMI2 foreign key (VIS_TIP_UST, VU_IDENTIFIKATOR, RS_IDENTIFIKATOR)
      references RUKOVODNA_SEMA (VIS_TIP_UST, VU_IDENTIFIKATOR, RS_IDENTIFIKATOR) on delete restrict on update restrict;

alter table RADNA_MESTA add constraint FK_SISTEMATIZACIJA foreign key (TIP_UST, VU_IDENTIFIKATOR)
      references VISOKOSKOLSKA_USTANOVA (TIP_UST, VU_IDENTIFIKATOR) on delete restrict on update restrict;

alter table RASPOREDI_NA_RADNA_MESTA add constraint FK_DODELJENI_ZAPOSLENI foreign key (REG_TIP_UST, REG_VU_IDENTIFIKATOR, OJ_IDENTIFIKATOR)
      references ORGANIZACIONE_JEDINICE (TIP_UST, VU_IDENTIFIKATOR, OJ_IDENTIFIKATOR) on delete restrict on update restrict;

alter table RASPOREDI_NA_RADNA_MESTA add constraint FK_KO_JE_RASPOREDJEN foreign key (REG_TIP_UST, REG_VU_IDENTIFIKATOR, RM_OZNAKA)
      references RADNA_MESTA (TIP_UST, VU_IDENTIFIKATOR, RM_OZNAKA) on delete restrict on update restrict;

alter table RASPOREDI_NA_RADNA_MESTA add constraint FK_RASPORED_RADA foreign key (REG_TIP_UST, REG_VU_IDENTIFIKATOR, ZAP_REDNI_BROJ)
      references REGISTAR_ZAPOSLENIH (TIP_UST, VU_IDENTIFIKATOR, ZAP_REDNI_BROJ) on delete restrict on update restrict;

alter table RASPOREDI_NA_RADNA_MESTA add constraint FK_VRSTA_U_USTANOVI foreign key (VRO_OZNAKA)
      references VRSTA_RADNOG_ODNOSA (VRO_OZNAKA) on delete restrict on update restrict;

alter table REGISTAR_GRUPA_OBRAZOVANJA add constraint FK_IMA_GRUPE foreign key (PO_POLJE)
      references REGISTAR_OBRAZOVNIH_POLJA (PO_POLJE) on delete restrict on update restrict;

alter table REGISTAR_OBLASTI_OBRAZOVANJA add constraint FK_IMA_OBLASTI foreign key (PO_POLJE, GRU_GRUPA)
      references REGISTAR_GRUPA_OBRAZOVANJA (PO_POLJE, GRU_GRUPA) on delete restrict on update restrict;

alter table REGISTAR_ZAPOSLENIH add constraint FK_UPOSLJAVA foreign key (TIP_UST, VU_IDENTIFIKATOR)
      references VISOKOSKOLSKA_USTANOVA (TIP_UST, VU_IDENTIFIKATOR) on delete restrict on update restrict;

alter table REGISTAR_ZAPOSLENIH add constraint FK_ZAPOSLEN_KOD_POSLODAVCA foreign key (TIP_UST, VU_IDENTIFIKATOR, CLA_ZAP_REDNI_BROJ, RCP_REDNI_BROJ)
      references CLANOVI_PODORICE (TIP_UST, VU_IDENTIFIKATOR, ZAP_REDNI_BROJ, RCP_REDNI_BROJ) on delete restrict on update restrict;

alter table REGISTROVANI_PROGRAMI add constraint FK_DIPLOMIRANJEM_POSTAJE foreign key (SN_OZNAKA)
      references REGISTAR_STRUCNIH_NAZIVA (SN_OZNAKA) on delete restrict on update restrict;

alter table REGISTROVANI_PROGRAMI add constraint FK_JEZIK_PROGRAMA foreign key (JEZ_JERIK2)
      references JEZICI (JEZ_JERIK2) on delete restrict on update restrict;

alter table REGISTROVANI_PROGRAMI add constraint FK_STEPEN_I_NIVO_STUDIJA foreign key (STS_OZNAKA, NS_NIVO)
      references NIVO_STUDIJA (STS_OZNAKA, NS_NIVO) on delete restrict on update restrict;

alter table REGISTROVANI_PROGRAMI add constraint FK_STUDIJSKI_PROGRAMI_USTANOVE foreign key (TIP_UST, VU_IDENTIFIKATOR)
      references VISOKOSKOLSKA_USTANOVA (TIP_UST, VU_IDENTIFIKATOR) on delete restrict on update restrict;

alter table REGISTROVANI_PROGRAMI add constraint FK_TIPIZIRANI_PROGRAMI foreign key (TIPP_TIP)
      references TIP_PROGRAMA (TIPP_TIP) on delete restrict on update restrict;

alter table RUKOVODNA_SEMA add constraint FK_FORMIRAN_OD_STRANE foreign key (VIS_TIP_UST, VU_IDENTIFIKATOR, OJ_IDENTIFIKATOR)
      references ORGANIZACIONE_JEDINICE (TIP_UST, VU_IDENTIFIKATOR, OJ_IDENTIFIKATOR) on delete restrict on update restrict;

alter table RUKOVODNA_SEMA add constraint FK_POSEBNE_POZICIJE foreign key (VIS_TIP_UST, VU_IDENTIFIKATOR)
      references VISOKOSKOLSKA_USTANOVA (TIP_UST, VU_IDENTIFIKATOR) on delete restrict on update restrict;

alter table SASTAV_JEDINICE add constraint FK_JEDINICA_U_SASTAVU foreign key (ORG_TIP_UST, ORG_VU_IDENTIFIKATOR, OJ_IDENTIFIKATOR)
      references ORGANIZACIONE_JEDINICE (TIP_UST, VU_IDENTIFIKATOR, OJ_IDENTIFIKATOR) on delete restrict on update restrict;

alter table SASTAV_JEDINICE add constraint FK_SLOZENA_JEDINICA foreign key (ORG_TIP_UST, ORG_VU_IDENTIFIKATOR, ORG_OJ_IDENTIFIKATOR)
      references ORGANIZACIONE_JEDINICE (TIP_UST, VU_IDENTIFIKATOR, OJ_IDENTIFIKATOR) on delete restrict on update restrict;

alter table SASTAV_SLOZENE_USTANOVE add constraint FK_SASTAV_SLOZENE_USTANOVE foreign key (TIP_UST, AKT_VU_IDENTIFIKATOR, AO_REDNI_BROJ)
      references AKT_O_ORGANIZACIJI (TIP_UST, VU_IDENTIFIKATOR, AO_REDNI_BROJ) on delete restrict on update restrict;

alter table SASTAV_SLOZENE_USTANOVE add constraint FK_SASTAV_SLOZENE_USTANOVE2 foreign key (VIS_TIP_UST, VU_IDENTIFIKATOR)
      references VISOKOSKOLSKA_USTANOVA (TIP_UST, VU_IDENTIFIKATOR) on delete restrict on update restrict;

alter table SKOLPLENI_SA add constraint FK_SKOLPLENI_SA foreign key (DOK_TIP_UST, VU_IDENTIFIKATOR, VD_OZNAKA, UG_GODINA, UG_BROJ_UGOVORA)
      references DOKUMENTI_O_ZAPOSLENIM (TIP_UST, VU_IDENTIFIKATOR, VD_OZNAKA, UG_GODINA, UG_BROJ_DOKUMENTA) on delete restrict on update restrict;

alter table SKOLPLENI_SA add constraint FK_SKOLPLENI_SA2 foreign key (TIP_UST, REG_VU_IDENTIFIKATOR, ZAP_REDNI_BROJ)
      references REGISTAR_ZAPOSLENIH (TIP_UST, VU_IDENTIFIKATOR, ZAP_REDNI_BROJ) on delete restrict on update restrict;

alter table SLOZENA_DRZAVA add constraint FK_DR_AVA_U_SASTAVU foreign key (DRZ_DR_IDENTIFIKATOR)
      references DRZAVA (DR_IDENTIFIKATOR) on delete restrict on update restrict;

alter table SLOZENA_DRZAVA add constraint FK_SLOZENA_DRZAVA foreign key (DR_IDENTIFIKATOR)
      references DRZAVA (DR_IDENTIFIKATOR) on delete restrict on update restrict;

alter table SLUZBENI_JEZICI add constraint FK_SLUZBENI_JEZICI foreign key (JEZ_JERIK2)
      references JEZICI (JEZ_JERIK2) on delete restrict on update restrict;

alter table SLUZBENI_JEZICI add constraint FK_SLUZBENI_JEZICI2 foreign key (DR_IDENTIFIKATOR)
      references DRZAVA (DR_IDENTIFIKATOR) on delete restrict on update restrict;

alter table STRUKTURA_DOKUMENTACIJE add constraint FK_OSNOVNI foreign key (JEZ_JERIK2, OSNOVNI_TIP_DOKUMENTA)
      references TIP_DOKUMENTACIJE (JEZ_JERIK2, TIP_DOKUMENTA) on delete restrict on update restrict;

alter table STRUKTURA_DOKUMENTACIJE add constraint FK_SADRZANI foreign key (JEZ_JERIK2, SADRZANI_TIP_DOKUMENTA)
      references TIP_DOKUMENTACIJE (JEZ_JERIK2, TIP_DOKUMENTA) on delete restrict on update restrict;

alter table STRUKTURA_PROGRAMA add constraint FK_BLOK_NASTAVE foreign key (ON_OZNAKA)
      references ORGANIZACIJA_NASTAVE (ON_OZNAKA) on delete restrict on update restrict;

alter table STRUKTURA_PROGRAMA add constraint FK_STRUKTURIRANJE_PROGRAMA foreign key (TIP_UST, VU_IDENTIFIKATOR, TIPP_TIP, SP_EVIDENCIONI_BROJ, SP_VERZIJA)
      references REGISTROVANI_PROGRAMI (TIP_UST, VU_IDENTIFIKATOR, TIPP_TIP, SP_EVIDENCIONI_BROJ, SP_VERZIJA) on delete restrict on update restrict;

alter table STRUKTURIRANE_KATEGORIJE add constraint FK_OSNOVNA_KATEGORIJA foreign key (PO_POLJE, GRU_GRUPA, OBL_OBLAST, KOMP_KATEGORIJA)
      references KATEGORIJA_KOMPETENCIJE (PO_POLJE, GRU_GRUPA, OBL_OBLAST, KOMP_KATEGORIJA) on delete restrict on update restrict;

alter table STRUKTURIRANE_KATEGORIJE add constraint FK_POVEZANA_KATEGORIJA foreign key (PO_POLJE, GRU_GRUPA, OBL_OBLAST, KAT_KOMP_KATEGORIJA)
      references KATEGORIJA_KOMPETENCIJE (PO_POLJE, GRU_GRUPA, OBL_OBLAST, KOMP_KATEGORIJA) on delete restrict on update restrict;

alter table STRUKTURIRANE_KOMPETENCIJE add constraint FK_OSNOVNA_KOMPETENCIJ foreign key (PO_POLJE, GRU_GRUPA, OBL_OBLAST, KOMP_KATEGORIJA, KO_KOMPETENCIJA)
      references KOMPETENCIJE (PO_POLJE, GRU_GRUPA, OBL_OBLAST, KOMP_KATEGORIJA, KO_KOMPETENCIJA) on delete restrict on update restrict;

alter table STRUKTURIRANE_KOMPETENCIJE add constraint FK_STRUKTURIRANE_KOMPETENCIJE2 foreign key (PO_POLJE, GRU_GRUPA, OBL_OBLAST, KOMP_KATEGORIJA, KOM_KO_KOMPETENCIJA)
      references KOMPETENCIJE (PO_POLJE, GRU_GRUPA, OBL_OBLAST, KOMP_KATEGORIJA, KO_KOMPETENCIJA) on delete restrict on update restrict;

alter table TIP_DOKUMENTACIJE add constraint FK_NA_JEZICIMA foreign key (JEZ_JERIK2)
      references JEZICI (JEZ_JERIK2) on delete restrict on update restrict;

alter table U_DRZAVI add constraint FK_NASELJENA_MESTA foreign key (DR_IDENTIFIKATOR)
      references DRZAVA (DR_IDENTIFIKATOR) on delete restrict on update restrict;

alter table U_DRZAVI add constraint FK_U_DRZAVAMA foreign key (NM_IDENTIFIKATOR)
      references NASELJENO_MESTO (NM_IDENTIFIKATOR) on delete restrict on update restrict;

alter table VISOKOSKOLSKA_USTANOVA add constraint FK_IMA_VISIKOSKOLSKE_USTANOVE foreign key (NM_IDENTIFIKATOR)
      references NASELJENO_MESTO (NM_IDENTIFIKATOR) on delete restrict on update restrict;

alter table VISOKOSKOLSKA_USTANOVA add constraint FK_REGISTROVANE_USTANOVA foreign key (DR_IDENTIFIKATOR)
      references DRZAVA (DR_IDENTIFIKATOR) on delete restrict on update restrict;

alter table VISOKOSKOLSKA_USTANOVA add constraint FK_TIPIZIRA_USTANOVE foreign key (TIP_UST)
      references TIPOVI_USTANOVA (TIP_UST) on delete restrict on update restrict;

alter table VISOKOSKOLSKA_USTANOVA add constraint FK_VLASNICKA_ODREDNICA foreign key (VV_OZNAKA)
      references VRSTA_VLASNISTVA (VV_OZNAKA) on delete restrict on update restrict;

alter table ZA_OBLASTI_OBRAZOVANJA add constraint FK_ZA_OBLASTI_OBRAZOVANJA foreign key (PO_POLJE, GRU_GRUPA, OBL_OBLAST)
      references REGISTAR_OBLASTI_OBRAZOVANJA (PO_POLJE, GRU_GRUPA, OBL_OBLAST) on delete restrict on update restrict;

alter table ZA_OBLASTI_OBRAZOVANJA add constraint FK_ZA_OBLASTI_OBRAZOVANJA2 foreign key (TIP_UST, VU_IDENTIFIKATOR, TIPP_TIP, SP_EVIDENCIONI_BROJ, SP_VERZIJA)
      references REGISTROVANI_PROGRAMI (TIP_UST, VU_IDENTIFIKATOR, TIPP_TIP, SP_EVIDENCIONI_BROJ, SP_VERZIJA) on delete restrict on update restrict;

