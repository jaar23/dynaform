module entities

import time { Time }

@[table: 'form_data']
pub struct FormData {
	id           int    @[primary; sql: serial]
	form_id      int    @[references: 'form(id)']
	form_item_id int    @[references: 'form_item(id)']
	seq          int
	version      int
	float_val    f64
	int_val      int
	str_val      string
	bool_val     bool
	created_by   string
	created_at   Time   @[sql_type: 'TIMESTAMP'; default: 'CURRENT_TIME']
	updated_by   string
	updated_at   ?Time  @[sql_type: 'TIMESTAMP']
}
