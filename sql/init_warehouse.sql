/* ============================================================
   1. DATABASE & SCHEMAS
   ============================================================ */

CREATE OR REPLACE DATABASE IDEPENSE;
USE DATABASE IDEPENSE;

CREATE OR REPLACE SCHEMA ODS;
CREATE OR REPLACE SCHEMA DWH;


/* ============================================================
   2. ODS  (tabelle = fogli Excel)
   ============================================================ */
   
USE DATABASE IDEPENSE;
USE SCHEMA ODS;

-- 2.1 Liste détaillée des catégories
--     colonna: "Catégorie"
CREATE OR REPLACE TABLE CATEGORIE_DEPENSE (
    CATEGORIE          VARCHAR
);

-- 2.2 Liste détaillée des sous-catégories
--     colonne: "Sous-catégorie", "Catégorie"
CREATE OR REPLACE TABLE SOUS_CATEGORIE_DEPENSE (
    SOUS_CATEGORIE     VARCHAR,
    CATEGORIE          VARCHAR
);

-- 2.3 Liste détaillée des dépenses
--     colonne:
--     "Numéro dépense", "Date dépense", "Description dépense",
--     "Catégorie dépense", "Sous-catégorie dépense", "Montant dépense"
CREATE OR REPLACE TABLE DEPENSE (
    NUMERO_DEPENSE         VARCHAR,
    DATE_DEPENSE           DATE,
    DESCRIPTION_DEPENSE    VARCHAR,
    CATEGORIE_DEPENSE      VARCHAR,
    SOUS_CATEGORIE_DEPENSE VARCHAR,
    MONTANT_DEPENSE        NUMBER(10,2)
);


SELECT * FROM ods.CATEGORIE_DEPENSE;
SELECT * FROM ods.SOUS_CATEGORIE_DEPENSE;
SELECT * FROM ods.DEPENSE;

/* ============================================================
   3. DWH  (dimensioni + fatto)
   coerente con i job:
   - jDimSousCategorieDepense_ODS_DWH
   - jDimDescriptionDepense_ODS_DWH
   - jDimTemp_ODS_DWH
   - jFaitDepense_ODS_DWH
   ============================================================ */

USE DATABASE IDEPENSE;
USE SCHEMA DWH;

-- 3.1 Dimensione Sotto-categoria spesa
CREATE OR REPLACE TABLE DIM_SOUS_CATEGORIE_DEPENSE (
    SK_SOUS_CATEGORIE       NUMBER      PRIMARY KEY,
    SOUS_CATEGORIE          VARCHAR,
    CATEGORIE               VARCHAR
);

-- 3.2 Dimensione Descrizione spesa
CREATE OR REPLACE TABLE DIM_DESCRIPTION_DEPENSE (
    SK_DESCRIPTION          NUMBER      PRIMARY KEY,
    DESCRIPTION_DEPENSE     VARCHAR
);

-- 3.3 Dimensione Tempo
CREATE OR REPLACE TABLE DIM_TEMPS (
 	date_calendar		 		DATE  NOT NULL,
	num_date_calendar		 	INTEGER  NOT NULL,
	num_month		 			INTEGER NOT NULL,
	lib_month		 			VARCHAR(100) NOT NULL,
	lib_quater					VARCHAR(5) NOT NULL,
    lib_semester				VARCHAR(5) NOT NULL,
	num_year					INTEGER NOT NULL,
CONSTRAINT pk_dim_time PRIMARY KEY (date_calendar)
);

-- 3.4 Fact table delle spese
CREATE OR REPLACE TABLE FAIT_DEPENSE (
    SK_DEPENSE              VARCHAR(6)      PRIMARY KEY,

    --SK_DATE                 NUMBER,
    SK_DATE                 DATE,
    SK_SOUS_CATEGORIE       NUMBER,
    SK_DESCRIPTION          NUMBER,

    MONTANT_DEPENSE         NUMBER(10,2)
    --NBR_DEPENSE             NUMBER      DEFAULT 1
);


SELECT * FROM DWH.DIM_SOUS_CATEGORIE_DEPENSE;
SELECT * FROM IDEPENSE.DWH.DIM_DESCRIPTION_DEPENSE;
SELECT * FROM IDEPENSE.DWH.DIM_TEMPS;
SELECT * FROM IDEPENSE.DWH.FAIT_DEPENSE;


/*CREATE OR REPLACE TABLE DIM_TEMPS (
    SK_DATE                 NUMBER      PRIMARY KEY,   -- es. 20220101
    DATE_COMPLETE           DATE,
    ANNEE                   NUMBER,
    MOIS                    NUMBER,
    NOM_MOIS                VARCHAR,
    JOUR                    NUMBER,
    JOUR_SEMAINE            VARCHAR
);*/