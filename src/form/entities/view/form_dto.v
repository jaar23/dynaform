module view

import enums

pub struct TemplateCreateDto {
pub:
	id         int
	name       string
	status     enums.TemplateStatus
}
