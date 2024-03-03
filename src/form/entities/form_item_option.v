module entities

import enums { DataType }

@[table: 'form_item_option']
pub struct FormItemOption {
	form_item_id int      @[reference: 'form_item(id)']
	label        string
	key          string
	value        string
	data_type    DataType
	description  string
}
