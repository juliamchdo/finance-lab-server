import dayjs from "dayjs";
import { prisma } from "./prisma";
import { FastifyInstance } from "fastify";
import {z} from 'zod';

export async function appRoutes(app: FastifyInstance){
    //cria um novo lançamento
    app.post('/novo-lancamento', async (request) => {
        const createLancamento = z.object({
            description: z.string(),
            type: z.string(),
            value: z.number()
        })

        //valida e converte os dados em um objeto (para POST ou PUT)
        const {description, value, type} = createLancamento.parse(request.body);

        const today = dayjs().startOf('date').toDate();

        await prisma.lancamento.create({
            data:{
                description,
                type,
                value,
                date: today
            }
        }).catch(e => {
            console.log(e)
        })
    })

    //edita um lançamento já existente
    app.post('/editar-lancamento', async (request) => {
        const editLancamento = z.object({
            id: z.string(),
            description: z.string(),
            type: z.string(),
            value: z.number(),
            date: z.coerce.string()
        })

        const {id, description, value, type, date} = editLancamento.parse(request.body);

        await prisma.lancamento.update({
            where:{
                id: id
            },
            data:{
                description,
                type,
                value,
                date
            }
       }).catch(e =>{
        console.log(e)
       })
    })

    //retorna todas as movimentações existentes
    app.get('/resumo', async() => {
        const movimentacao = prisma.lancamento.findMany();
        return movimentacao;
    })

    //retorna as movimentações de acordo com um período específico
    app.get('/lancamentos', async(request) =>{

        //converte as datas recebidas em string para date
        const getDates = z.object({
            dataInicio: z.coerce.date(),
            dataFim: z.coerce.date(),
        })      

        const {dataInicio, dataFim} = getDates.parse(request.query)
        // const parsedDataInicio = dayjs(dataInicio).startOf('date')
        // const parsedDataFim = dayjs(dataFim).startOf('date')

       const movimentacoes = await prisma.lancamento.findMany({
        where:{
            date:{
                gte: dataInicio,
                lte: dataFim
            }
        }
       })

       return movimentacoes

    })

    //retorna o saldo total
    app.get('/total', async () => {

        interface Movimentacao {
            total: number
        }

        let totalMovimentacoes: Movimentacao[];

        totalMovimentacoes = await prisma.$queryRaw`
            SELECT SUM(CASE WHEN type = 'ENTRADA' THEN value ELSE -value END) as total
            FROM lancamentos
        `
        const total = Number(totalMovimentacoes[0].total);
        return total;
    })
    
    //deleta lançamentos
    app.delete('/', async (request) => {
        console.log(request.query)
        const deleteLancamento = z.object({
            id: z.string()
        })

        const { id } = deleteLancamento.parse(request.query)
        console.log(id)

        await prisma.lancamento.delete({
            where:{
                id: id
            }
        })
    })
      
}