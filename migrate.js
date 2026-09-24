import 'dotenv/config';
import fs from 'node:fs/promises';
import pg from 'pg';
const {Pool}=pg;
const pool=new Pool({connectionString:process.env.DATABASE_URL});
const sql=await fs.readFile(new URL('./schema.sql',import.meta.url),'utf8');
await pool.query(sql); await pool.end(); console.log('Database ready.');
