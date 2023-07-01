/*
  Warnings:

  - You are about to drop the column `description` on the `lancamentos` table. All the data in the column will be lost.
  - You are about to drop the column `type` on the `lancamentos` table. All the data in the column will be lost.
  - You are about to drop the column `value` on the `lancamentos` table. All the data in the column will be lost.
  - Added the required column `descricao` to the `lancamentos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tipo` to the `lancamentos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `valor` to the `lancamentos` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_lancamentos" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "descricao" TEXT NOT NULL,
    "tipo" TEXT NOT NULL,
    "valor" DECIMAL NOT NULL,
    "date" DATETIME NOT NULL
);
INSERT INTO "new_lancamentos" ("date", "id") SELECT "date", "id" FROM "lancamentos";
DROP TABLE "lancamentos";
ALTER TABLE "new_lancamentos" RENAME TO "lancamentos";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
