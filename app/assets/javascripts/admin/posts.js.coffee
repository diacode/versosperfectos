window.VPADMIN.posts.init = ->
	# Inicializamos el selector de tags
	$("#post_tag_list").select2
		minimumInputLength: 2
		placeholder: "Añade etiquetas a la noticia"
		multiple: true
		ajax:
			url: "/admin/posts/tags.json"
			dataType: "json"
			data: (term, page) ->
				return {
					filter: term
				}
			results: (data, page) ->
				return {
					results: data
				}
		formatResult: (tag) ->
			"<div>"+tag.name+"</div>"		
		formatSelection: (tag) ->
			tag.name

		initSelection: (element, callback) ->
			previous_tags = []
			$($(element).val().split(",")).each (idx, item) ->
				previous_tags.push {id: item, name: item}
			
			callback previous_tags

		createSearchChoice: (term, data) ->
			pos_comma = term.indexOf(",")

			term = term.substr(0, term.indexOf(",")) if pos_comma != -1

			return {
				id: term
				name: term
			}

		formatNoMatches: (term) ->
			"No se produjeron resultados para la cadena #{term}"

		formatInputTooShort: (term, minLength) ->
			"La cadena de búsqueda es muy corta. Inserte #{minLength-term.length} carácteres más."

	$("#toggle_publish_twitter").click (e) ->
		if !$(@).hasClass("active")
			if $("#post_twitter_message").val() == ""
				post_title = $("#post_title").val()
				$("#post_twitter_message").val(post_title)
				matches = /^(Video: )?(.*) \- .*$/.exec(post_title)
				artist = matches[2]
				$("#twitter_lookup").val(artist)

			$(".twitter-message-wrapper").show()
			$("#post_flag_twitter").prop("checked", true)
		else
			$(".twitter-message-wrapper").hide()
			$("#post_flag_twitter").prop("checked", false)

	$("#toggle_publish_facebook").click (e) ->
		if !$(@).hasClass("active")
			$("#post_flag_facebook").prop("checked", true)
		else
			$("#post_flag_facebook").prop("checked", false)

	$("#post_publish").on "click", (ev) ->
		$("#post_draft").prop("checked", false)
		$('#form_post').submit()

	$("#post_save_as_draft").on "click", (ev) ->
		$("#post_draft").prop("checked", true)
		$('#form_post').submit()

	$("#btn_twitter_lookup").on "click", (ev) ->
		$("#twitter_lookup_status").text("")
		$("#twitter_lookup_status").addClass("loading")

		$.ajax
			url: Routes.twitter_lookup_admin_artists_path()
			dataType: 'json'
			type: 'get'
			data:
				q: $("#twitter_lookup").val()
			success: (data) ->
				$("#twitter_lookup_status").removeClass("loading")

				if data != null && data.twitter != ""
					twitter_account = "@#{data.twitter}"
					twitter_message = $("#post_twitter_message").val()
					edited_twitter_message = twitter_message.replace /^(Video: )?(.*)( \- .*)$/, "$1#{twitter_account}$3"
					$("#post_twitter_message").val(edited_twitter_message)
				else
					$("#twitter_lookup_status").text("La búsqueda no produjo resultados.")

	# Inicialización form búsqueda de noticias
	$("#post_search_form #tags").select2
		minimumInputLength: 2
		placeholder: "Tags"
		multiple: true
		width: '100%'
		ajax:
			url: "/admin/posts/tags.json"
			dataType: "json"
			data: (term, page) ->
				return {
					filter: term
				}
			results: (data, page) ->
				return {
					results: data
				}
		formatResult: (tag) ->
			"<div>"+tag.name+"</div>"		
		formatSelection: (tag) ->
			tag.name

		formatNoMatches: (term) ->
			"No se produjeron resultados para la cadena #{term}"

		formatInputTooShort: (term, minLength) ->
			"La cadena de búsqueda es muy corta. Inserte #{minLength-term.length} carácteres más."

	$("#post_search_form").on 'submit', (e) ->
		$("table.post_search_results tbody tr").remove()

		e.preventDefault()
		
		query = $(@).find("#q").val()
		tagsStr = $(@).find("#tags").val()
		tags = if tagsStr isnt "" then tagsStr.split(",") else []

		$.ajax
			url: '/admin/posts/search.json'
			dataType: 'json'
			type: 'get'
			data:
				q: query
				tags: tags
			success: (data) ->
				for post in data
					tr = $("<tr/>")

					td_id = $("<td/>").text(post.id)
					td_link = $("<td/>")
					td_action = $("<td/>")

					link = $("<a/>")
						.attr("href", post.public_url)
						.attr("target", "_blank")
						.text(post.title)

					action = $("<button/>")
						.attr("type", "button")
						.addClass("btn btn-small add-link-to-body")
						.html('<i class="icon-plus"></i>')

					td_link.append(link)
					td_action.append(action)

					tr.append(td_id, td_link, td_action)

					$(".post_search_results tbody").append(tr)

	$("table.post_search_results").on 'click', '.add-link-to-body', (e) ->
		btn = $(e.currentTarget)
		link = btn.parents('tr').find("a")
		link_text = link.text()
		link_url = link.attr('href')
		$("#post_content").redactor('insertHtml', "<p><a href=\"#{link_url}\">#{link_text}</a></p>")
