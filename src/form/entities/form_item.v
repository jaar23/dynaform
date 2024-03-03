module entities

import time { Time }
import enums { DataType, FormItemKind }

@[table: 'form_item']
pub struct FormItem {
	id               int          @[primary; sql: serial]
	form_id          int          @[references: 'form(id)']
	kind             FormItemKind
	data_type        DataType
	order            int
	label            string
	key              string
	active_when      string
	deactive_when    string
	dependencies     string
	requred          bool
	read_only        bool
	disabled         bool
	autofocus        bool
	grouped          bool
	multiple_val     bool
	value_from       string
	maxlength        int
	pattern_matching string
	placeholder      string
	tailwind_style   string
	created_by       string
	created_at       Time         @[default: 'CURRENT_TIME'; sql_type: 'TIMESTAMP']
	updated_by       string
	updated_at       ?Time        @[sql_type: 'TIMESTAMP']
}
