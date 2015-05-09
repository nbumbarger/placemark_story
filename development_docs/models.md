Planned Models:

User has many Story
	name; string
	deleted_at; datetime

	Story has many Placemark; belongs to User
		deleted_at; datetime

		Placemark has many images; belongs to Story
			name; string
			synopsis; text
			full_text; text
			lat; decimal
			lon; decimal
			deleted_at; datetime

		Image belongs to Placemark
			image: byta
			alt: string
			deleted_at; datetime
