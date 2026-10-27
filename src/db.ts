import {Pool} from 'pg';

export const pool = new Pool({
    host: 'localhost',
    port: 5433,
    user: 'postgres',
    password: 'postgres',
    database: 'ticketing_db',
    max: 10, // connection pool limit
});

export async function initDatabase() {
    await pool.query(`
        CREATE TABLE IF NOT EXISTS seats
        (
            id        VARCHAR(50) PRIMARY KEY,
            name      VARCHAR(100) NOT NULL,
            status    VARCHAR(20)  NOT NULL DEFAULT 'AVAILABLE',
            booked_by VARCHAR(50)
        );
    `);

    // Seed with one limited VIP seat
    await pool.query(`
        INSERT INTO seats (id, name, status)
        VALUES ('vip-pass', 'VIP Concert Pass', 'AVAILABLE')
        ON CONFLICT (id) DO UPDATE SET status    = 'AVAILABLE',
                                       booked_by = NULL;
    `);

    console.log('PostgreSQL initialized: seats table ready.');
}
