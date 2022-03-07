begin;
    create table account(
        id int primary key
    );
    comment on table account is e'@graphql({"totalCount": {"enabled": true}})';

    insert into account(id)
    select * from generate_series(1, 40);

    -- Requested 50, expect 30
    select jsonb_pretty(
        graphql.resolve($$
        {
          accountCollection(first: 50) {
            edges {
              node {
                id
              }
            }
          }
        }
        $$)
    );
