import fastify from "fastify";
import cors from '@fastify/cors';
import { appRoutes } from "./lib/routes";

const app = fastify();

//registro cors na aplicação para o frontend conseguir se comunicar
app.register(cors);
app.register(appRoutes);

app.listen({
    port: 3333,
    host: '0.0.0.0'
}).then(() => {
    console.log('HTTP Server Running!')
});