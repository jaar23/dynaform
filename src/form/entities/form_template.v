module entities

import time { Time }
import enums { TemplateStatus }

@[table: 'form_template']
pub struct FormTemplate {
	id         int            @[primary; sql: serial]
	name       string
	status     TemplateStatus
	created_at Time           @[default: 'CURRENT_TIME'; sql_type: 'TIMESTAMP']
	created_by string
	updated_at ?Time          @[sql_type: 'TIMESTAMP']
	updated_by string
	deleted_at ?Time          @[sql_type: 'TIMESTAMP']
	deleted_by string
}

