#
# Copyright 2016 LinkedIn Corp.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.
#

# --- !Ups


CREATE TABLE yarn_app_result (
  id               VARCHAR(50)   NOT NULL PRIMARY KEY,
  name             VARCHAR(100)  NOT NULL,
  username         VARCHAR(50)   NOT NULL,
  queue_name       VARCHAR(50)   DEFAULT NULL,
  start_time       BIGINT        NOT NULL,
  finish_time      BIGINT        NOT NULL,
  tracking_url     VARCHAR(255)  NOT NULL,
  job_type         VARCHAR(20)   NOT NULL,
  severity         SMALLINT      NOT NULL,
  score            BIGINT        DEFAULT 0,
  workflow_depth   SMALLINT      DEFAULT 0,
  scheduler        VARCHAR(20)   DEFAULT NULL,
  job_name         VARCHAR(255)  NOT NULL DEFAULT '',
  job_exec_id      VARCHAR(800)  NOT NULL DEFAULT '',
  flow_exec_id     VARCHAR(255)  NOT NULL DEFAULT '',
  job_def_id       VARCHAR(800)  NOT NULL DEFAULT '',
  flow_def_id      VARCHAR(800)  NOT NULL DEFAULT '',
  job_exec_url     VARCHAR(800)  NOT NULL DEFAULT '',
  flow_exec_url    VARCHAR(800)  NOT NULL DEFAULT '',
  job_def_url      VARCHAR(800)  NOT NULL DEFAULT '',
  flow_def_url     VARCHAR(800)  NOT NULL DEFAULT ''
);

create index yarn_app_result_i1 on yarn_app_result (finish_time);
create index yarn_app_result_i2 on yarn_app_result (username,finish_time);
create index yarn_app_result_i3 on yarn_app_result (job_type,username,finish_time);
create index yarn_app_result_i4 on yarn_app_result (flow_exec_id);
create index yarn_app_result_i5 on yarn_app_result (job_def_id);
create index yarn_app_result_i6 on yarn_app_result (flow_def_id);
create index yarn_app_result_i7 on yarn_app_result (start_time);

CREATE TABLE yarn_app_heuristic_result (
  id                  BIGINT        NOT NULL PRIMARY KEY,
  yarn_app_result_id  VARCHAR(50)   NOT NULL,
  heuristic_class     VARCHAR(255)  NOT NULL,
  heuristic_name      VARCHAR(128)  NOT NULL,
  severity            SMALLINT      NOT NULL,
  score               BIGINT        DEFAULT 0,
  CONSTRAINT yarn_app_heuristic_result_f1 FOREIGN KEY (yarn_app_result_id) REFERENCES yarn_app_result (id)
);

CREATE SEQUENCE yarn_app_heuristic_result_seq;

ALTER TABLE yarn_app_heuristic_result ALTER COLUMN id SET DEFAULT nextval('yarn_app_heuristic_result_seq');

create index yarn_app_heuristic_result_i1 on yarn_app_heuristic_result (yarn_app_result_id);
create index yarn_app_heuristic_result_i2 on yarn_app_heuristic_result (heuristic_name,severity);

CREATE TABLE yarn_app_heuristic_result_details (
  yarn_app_heuristic_result_id  BIGINT       NOT NULL,
  name                          VARCHAR(128) NOT NULL DEFAULT '',
  value                         VARCHAR(255) NOT NULL DEFAULT '',
  details                       TEXT,
  PRIMARY KEY (yarn_app_heuristic_result_id, name),
  CONSTRAINT yarn_app_heuristic_result_details_f1 FOREIGN KEY (yarn_app_heuristic_result_id) REFERENCES yarn_app_heuristic_result (id)
);

create index yarn_app_heuristic_result_details_i1 on yarn_app_heuristic_result_details (name);

# --- !Downs

SET FOREIGN_KEY_CHECKS=0;

DROP TABLE yarn_app_result;

DROP TABLE yarn_app_heuristic_result;

DROP TABLE yarn_app_heuristic_result_details;

SET FOREIGN_KEY_CHECKS=1;

# --- Created by Ebean DDL
# To stop Ebean DDL generation, remove this comment and start using Evolutions
