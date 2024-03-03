module models

import time { Time }

@[table: 'form']
pub struct Form {
	id               int    @[primary; sql: serial]
	form_template_id int    @[references: 'form_template(id)']
	created_by       string
	created_at       Time   @[sql_type: 'TIMESTAMP'; default: 'CURRENT_TIME']
	updated_by       string
	updated_at       ?Time  @[sql_type: 'TIMESTAMP']
}
