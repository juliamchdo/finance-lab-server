/*
  Warnings:

  - You are about to drop the `habits` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "habits";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "lancamentos" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "tipo" TEXT NOT NULL,
    "valor" DECIMAL NOT NULL,
    "data" DATETIME NOT NULL
);
