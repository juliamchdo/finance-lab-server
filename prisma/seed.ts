import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

//Função para popular o banco de dados com valores padrão, para facilitar o desenvolvimento
async function main() {
  await prisma.lancamento.deleteMany();

    await prisma.lancamento.create({
        data:{
            id: 'e125cd50-06e4-11ee-be56-0242ac120002',
            description: 'Mercado',
            type: 'SAIDA',
            value: 50,
            date: new Date('2023-05-06T00:00:00.000z')
        },
    }),

    await prisma.lancamento.create({
      data:{
          id: '405c40fa-06e6-11ee-be56-0242ac120002',
          description: 'Freela',
          type: 'ENTRADA',
          value: 180,
          date: new Date('2023-06-06T00:00:00.000z')
      },
  })
}

main()
  .then(async () => {
    await prisma.$disconnect()
  })
  .catch(async (e) => {
    console.error(e)
    await prisma.$disconnect()
    process.exit(1)
  })
