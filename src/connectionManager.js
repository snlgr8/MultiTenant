import knex from 'knex';

import commonDBConnection from './commonDBConnection';

let connectionMap;

/**
 *  Create knex instance for all the tenants defined in common database and store in a map.
 **/
export async function connectAllDb() {
  let tenants;

  try {
    tenants = await commonDBConnection.select('*').from('tenants');
  } catch (e) {
    console.log('error', e);

    return;
  }

  connectionMap = tenants
    .map((tenant) => {
      return {
        [tenant.slug]: knex(createConnectionConfig(tenant)),
      };
    })
    .reduce((prev, next) => {
      return Object.assign({}, prev, next);
    }, {});
}

/**
 *  Create configuration object for the given tenant.
 **/
function createConnectionConfig(tenant) {
  return {
    client: process.env.DB_CLIENT,
    connection: {
      host: tenant.db_host,
      port: tenant.db_port,
      user: tenant.db_username,
      database: tenant.db_name,
      password: tenant.db_password,
    },
    pool: { min: 2, max: 20 },
  };
}

import { getNamespace } from 'continuation-local-storage';

/**
 *  Get the connection information (knex instance) for the given tenant's slug.
 **/
export function getConnectionBySlug(slug) {
  if (connectionMap) {
    return connectionMap[slug];
  }
}

/**
 *  Get the connection information (knex instance) for current context.
 **/
export function getConnection() {
  const nameSpace = getNamespace('unique context');
  const conn = nameSpace.get('connection');

  if (!conn) {
    throw 'Connection is not set for any tenant database.';
  }

  return conn;
}
