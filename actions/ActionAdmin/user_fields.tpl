{include file='header.tpl'}


<h2 class="page-header">{$aLang.user_field_admin_title}</h2>

 
<a href="javascript:ls.userfield.showAddForm(this)" class="button" id="userfield_form_show">{$aLang.user_field_add}</a>

<br />
<br />

<div class="slide slide-bg-grey mb-10" id="userfield_form">
	<form>
		<p><label for="user_fields_form_type">{$aLang.userfield_form_type}:</label>
		<select id="user_fields_form_type" class="input-text input-width-full">
			<option value=""></option>
			{foreach from=$aUserFieldTypes item=sFieldType}
				<option value="{$sFieldType}">{$sFieldType}</option>
			{/foreach}
		</select></p>

		<p><label for="user_fields_form_name">{$aLang.userfield_form_name}:</label>
		<input type="text" id="user_fields_form_name" class="input-text input-width-full" /></p>
		
		<p><label for="user_fields_form_title">{$aLang.userfield_form_title}:</label>
		<input type="text" id="user_fields_form_title" class="input-text input-width-full" /></p>
		
		<p><label for="user_fields_form_pattern">{$aLang.userfield_form_pattern}:</label>
		<input type="text" id="user_fields_form_pattern" class="input-text input-width-full" /></p>
		
		<input type="hidden" id="user_fields_form_action" />
		<input type="hidden" id="user_fields_form_id" />
		
		<button type="button" onclick="ls.userfield.applyForm(); return false;" class="button button-primary">{$aLang.user_field_add}</button>
		<button type="button" onclick="ls.userfield.hideForm(); return false;" class="button">{$aLang.user_field_cancel}</button>
	</form>
</div>


<div class="userfield-list" id="user_field_list">
	{foreach from=$aUserFields item=oField}
		<div id="field_{$oField->getId()}" class="userfield-item">
			<strong class="userfield_admin_name">{$oField->getName()|escape:"html"}</strong>
			/ <span class="userfield_admin_title">{$oField->getTitle()|escape:"html"}</span>
            / <span class="userfield_admin_type">{$oField->getType()|escape:"html"}</span>
            / <span class="userfield_admin_pattern">{$oField->getPattern()|escape:"html"}</span>

			<div class="userfield-actions">
				{strip}
					<a href="#" onclick="ls.userfield.showEditForm({$oField->getId()}, this); return false;" title="{$aLang.user_field_update}" class="icon-edit"></a> 
					<a href="#" onclick="ls.userfield.deleteUserfield({$oField->getId()}); return false;" title="{$aLang.user_field_delete}" class="icon-delete"></a>
				{/strip}
			</div>
		</div>
	{/foreach}
</div>
	

{include file='footer.tpl'}