class X2DownloadableContentInfo_FortressNarrativeRestoration extends X2DownloadableContentInfo;

const NARRATIVE_DISABLE_FIRST_INDEX = 8;
const NARRATIVE_DISABLE_LAST_INDEX = 17;

static event OnPostTemplatesCreated ()
{
	local X2MissionNarrativeTemplateManager TemplateManager;

	TemplateManager = class'X2MissionNarrativeTemplateManager'.static.GetMissionNarrativeTemplateManager();

	DisableNarratives(TemplateManager.FindMissionNarrativeTemplate("GP_FortressLeadup"));
	DisableNarratives(TemplateManager.FindMissionNarrativeTemplate("GP_FortressShowdown"));
}

static private function DisableNarratives (X2MissionNarrativeTemplate Template)
{
	local int i;

	for (i = NARRATIVE_DISABLE_FIRST_INDEX; i <= NARRATIVE_DISABLE_LAST_INDEX; i++)
	{
		Template.NarrativeMoments[i] = "";
	}
}
