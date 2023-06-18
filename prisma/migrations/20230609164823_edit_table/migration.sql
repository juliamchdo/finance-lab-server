/*
  Warnings:

  - You are about to drop the column `data` on the `lancamentos` table. All the data in the column will be lost.
  - Added the required column `data_cadastro` to the `lancamentos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `descricao` to the `lancamentos` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_lancamentos" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "descricao" TEXT NOT NULL,
    "tipo" TEXT NOT NULL,
    "valor" DECIMAL NOT NULL,
    "data_cadastro" DATETIME NOT NULL
);
INSERT INTO "new_lancamentos" ("id", "tipo", "valor") SELECT "id", "tipo", "valor" FROM "lancamentos";
DROP TABLE "lancamentos";
ALTER TABLE "new_lancamentos" RENAME TO "lancamentos";
CREATE UNIQUE INDEX "lancamentos_data_cadastro_key" ON "lancamentos"("data_cadastro");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
