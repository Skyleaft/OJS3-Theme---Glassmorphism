{**
 * @file templates/plugins/generic/pdfJsViewer/templates/display.tpl
 *
 * Glass Theme — Custom PDF.js viewer template
 * Overrides the default PDF viewer to provide a premium glassmorphism interface.
 *}
<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>{translate key="article.pageTitle" title=$title|escape}</title>

	{load_header}
	{load_stylesheet context="frontend"}
    
    <style>
        :root {
            --color-accent: #6366f1;
            --color-accent-light: #818cf8;
            --glass-border: rgba(255, 255, 255, 0.1);
        }

        body {
            margin: 0;
            padding: 0;
            background: #0f172a;
            color: white;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            overflow: hidden;
            height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .pdf-header {
            background: rgba(15, 23, 42, 0.85);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border-bottom: 1px solid var(--glass-border);
            padding: 0.85rem 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 1000;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
        }

        .pdf-title-container {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 0 2rem;
            min-width: 0; /* Allow shrinking */
        }

        .pdf-title {
            font-size: 0.9rem;
            font-weight: 600;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            width: 100%;
            text-align: center;
            opacity: 0.95;
            letter-spacing: -0.01em;
        }

        .pdf-subtitle {
            font-size: 0.7rem;
            opacity: 0.5;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin-bottom: 0.15rem;
        }

        .pdf-actions {
            display: flex;
            gap: 0.75rem;
            min-width: fit-content;
        }

        .btn-glass {
            background: rgba(255, 255, 255, 0.06);
            border: 1px solid var(--glass-border);
            color: white;
            padding: 0.55rem 1.1rem;
            border-radius: 10px;
            text-decoration: none;
            font-size: 0.825rem;
            font-weight: 600;
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            align-items: center;
            gap: 0.6rem;
        }

        .btn-glass:hover {
            background: rgba(255, 255, 255, 0.12);
            border-color: rgba(255, 255, 255, 0.2);
            transform: translateY(-1px);
        }

        .btn-glass:active {
            transform: translateY(0);
        }

        .btn-primary {
            background: var(--color-accent);
            border-color: transparent;
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
        }

        .btn-primary:hover {
            background: var(--color-accent-light);
            box-shadow: 0 6px 16px rgba(99, 102, 241, 0.4);
        }

        .pdf-viewer-container {
            flex: 1;
            position: relative;
            background: #333; /* Default PDF.js background */
        }

        iframe {
            width: 100%;
            height: 100%;
            border: none;
        }

        @media (max-width: 768px) {
            .pdf-title-container {
                display: none;
            }
            .pdf-header {
                padding: 0.75rem 1rem;
            }
            .btn-glass span {
                display: none;
            }
            .btn-glass {
                padding: 0.6rem;
            }
        }
    </style>
</head>
<body>
	<header class="pdf-header">
		<a href="{$parentUrl}" class="btn-glass">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
                <path d="M19 12H5M12 19l-7-7 7-7"/>
            </svg>
			<span>{if $issue}{translate key="issue.return"}{else}{translate key="article.return"}{/if}</span>
		</a>
		
        <div class="pdf-title-container">
            <span class="pdf-subtitle">Previewing Galley</span>
            <div class="pdf-title">
                {if $isTitleHtml}
                    {$title|strip_unsafe_html}
                {else}
                    {$title|escape}
                {/if}
            </div>
		</div>

		<div class="pdf-actions">
			<a href="{$pdfUrl}" class="btn-glass btn-primary" download>
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
                    <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4M7 10l5 5 5-5M12 15V3"/>
                </svg>
				<span>{translate key="common.downloadPdf"}</span>
			</a>
		</div>
	</header>

	<div class="pdf-viewer-container">
		<iframe src="{$pluginUrl}/pdf.js/web/viewer.html?file={$pdfUrl|escape:"url"}" allowfullscreen webkitallowfullscreen></iframe>
	</div>

	{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
</html>
