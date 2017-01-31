# --- Indexing on queue for search by queue feature
# --- !Ups

alter table yarn_app_result add column resource_used    BIGINT DEFAULT 0;
alter table yarn_app_result add column resource_wasted  BIGINT DEFAULT 0;
alter table yarn_app_result add column total_delay      BIGINT DEFAULT 0;

# --- !Downs

alter table yarn_app_result drop resource_used;
alter table yarn_app_result drop resource_wasted;
alter table yarn_app_result drop total_delay;




