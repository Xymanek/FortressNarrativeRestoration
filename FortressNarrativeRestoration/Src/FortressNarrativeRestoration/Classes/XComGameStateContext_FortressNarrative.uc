class XComGameStateContext_FortressNarrative extends XComGameStateContext;

var int NarrativeIndex;

event string SummaryString ()
{
	return "Fortress Narrative -" @ NarrativeIndex;
}

function bool Validate(optional EInterruptionStatus InInterruptionStatus)
{
	// Supposedly we should check here that we are going to return a state in ContextBuildGameState or not
	// Unfortunately, game rules seem to never actually call this function so ¯\_(?)_/¯
	return true;
}

function XComGameState ContextBuildGameState ()
{
	// No actual changes - we only care about viz
	return `XCOMHISTORY.CreateNewGameState(true, self);
}

// (Extremely) Cut down version of SeqAct_ActivateNarrative
protected function ContextBuildVisualization ()
{
	local VisualizationActionMetadata ActionMetadata;
	local X2Action_PlayNarrative Narrative;

	Narrative = X2Action_PlayNarrative(class'X2Action_PlayNarrative'.static.AddToVisualizationTree(ActionMetadata, self));
	Narrative.Moment = LoadNarrativeMoment();
}

private function XComNarrativeMoment LoadNarrativeMoment ()
{
	return XComNarrativeMoment(DynamicLoadObject(class'X2EventListener_FortressNarrative'.default.PerTurnNarrativeMoments[NarrativeIndex], class'XComNarrativeMoment'));
}
