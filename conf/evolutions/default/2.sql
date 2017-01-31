# --- Indexing on queue for search by queue feature
# --- !Ups

create index yarn_app_result_i8 on yarn_app_result (queue_name);

# --- !Downs

drop index yarn_app_result_i8 on yarn_app_result;

