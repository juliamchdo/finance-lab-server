/*
  Warnings:

  - You are about to drop the column `data_cadastro` on the `lancamentos` table. All the data in the column will be lost.
  - You are about to drop the column `descricao` on the `lancamentos` table. All the data in the column will be lost.
  - You are about to drop the column `tipo` on the `lancamentos` table. All the data in the column will be lost.
  - You are about to drop the column `valor` on the `lancamentos` table. All the data in the column will be lost.
  - Added the required column `date` to the `lancamentos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `description` to the `lancamentos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `type` to the `lancamentos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `value` to the `lancamentos` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_lancamentos" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "description" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "value" DECIMAL NOT NULL,
    "date" DATETIME NOT NULL
);
INSERT INTO "new_lancamentos" ("id") SELECT "id" FROM "lancamentos";
DROP TABLE "lancamentos";
ALTER TABLE "new_lancamentos" RENAME TO "lancamentos";
CREATE UNIQUE INDEX "lancamentos_date_key" ON "lancamentos"("date");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
