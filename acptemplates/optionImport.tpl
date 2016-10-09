{include file='header' pageTitle='wcf.acp.option.importAndExport'}

<header class="contentHeader">
	<div class="contentHeaderTitle">
		<h1 class="contentTitle">{lang}{@$pageTitle}{/lang}</h1>
	</div>
	
	{hascontent}
		<nav class="contentHeaderNavigation">
			<ul>
				{content}{event name='contentHeaderNavigation'}{/content}
			</ul>
		</nav>
	{/hascontent}
</header>

{include file='formError'}

{if $success|isset}
	<p class="success">{lang}wcf.acp.option.import.success{/lang}</p>
{/if}

<div class="section tabMenuContainer" data-active="{$activeTabMenuItem}" data-store="activeTabMenuItem">
	<nav class="tabMenu">
		<ul>
			<li><a href="{@$__wcf->getAnchor('import')}">{lang}wcf.acp.option.import{/lang}</a></li>
			<li><a href="{@$__wcf->getAnchor('export')}">{lang}wcf.acp.option.export{/lang}</a></li>
		</ul>
	</nav>
	
	<div id="import" class="tabMenuContent">
		<form method="post" action="{link controller='OptionImport'}{/link}" enctype="multipart/form-data">
			<div class="section">
				<dl{if $errorField == 'optionImport'} class="formError"{/if}>
					<dt><label for="optionImport">{lang}wcf.acp.option.import.upload{/lang}</label></dt>
					<dd>
						<input type="file" id="optionImport" name="optionImport" value="" />
						{if $errorField == 'optionImport'}
							<small class="innerError">
								{if $errorType == 'empty'}
									{lang}wcf.global.form.error.empty{/lang}
								{else}
									{lang}wcf.acp.option.import.error.{@$errorType}{/lang}
								{/if}
							</small>
						{/if}
						<small>{lang}wcf.acp.option.import.upload.description{/lang}</small>
					</dd>
					
					{* {event name='importFields'} *}
				</dl>
			</div>
			
			{* {event name='importFieldsets'} *}
			
			<div class="formSubmit">
				<input type="submit" name="submitButton" value="{lang}wcf.global.button.submit{/lang}" accesskey="s" />
				{@SECURITY_TOKEN_INPUT_TAG}
			</div>
		</form>
	</div>
	
	<div id="export" class="tabMenuContent">
		<div class="section">
			<dl>
				<dt><label>{lang}wcf.acp.option.export.download{/lang}</label></dt>
				<dd>
					<p><a href="{link controller='OptionExport'}{/link}" id="optionExport" class="button">{lang}wcf.acp.option.export{/lang}</a></p>
					<small>{lang}wcf.acp.option.export.download.description{/lang}</small>
				</dd>
				
				{* {event name='exportFields'} *}
			</dl>
		</div>
		
		{* {event name='exportFieldsets'} *}
	</div>
</div>

{include file='footer'}
