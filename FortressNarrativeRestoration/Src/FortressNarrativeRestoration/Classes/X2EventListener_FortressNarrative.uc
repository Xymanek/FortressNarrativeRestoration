class X2EventListener_FortressNarrative extends X2EventListener;

var const array<string> PerTurnNarrativeMoments;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateListeners());

	return Templates;
}

static function X2EventListenerTemplate CreateListeners()
{
	local X2EventListenerTemplate Template;

	// We are ok with the default (not CHL) listener template
	`CREATE_X2TEMPLATE(class'X2EventListenerTemplate', Template, 'FortressNarrativeRestoration');
	Template.AddEvent('PlayerTurnBegun', OnPlayerTurnBegun);
	Template.RegisterInTactical = true;

	return Template;
}

static protected function EventListenerReturn OnPlayerTurnBegun (Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComGameStateContext_FortressNarrative NarrativeContext;
	local XComTacticalMissionManager MissionManager;
	local XComGameState_Player PlayerState;
	local int NarrativeIndex;

	PlayerState = XComGameState_Player(EventSource);
	if (PlayerState.TeamFlag != eTeam_XCom) return ELR_NoInterrupt;

	// Read correct version of player (although it's unlikely that we will get a whole turn cycle in a single game state chain)
	PlayerState = XComGameState_Player(GameState.GetGameStateForObjectID(PlayerState.ObjectID));

	// We first play narrative on turn 2, so turn 2 needs to become index 0
	NarrativeIndex = PlayerState.PlayerTurnCount - 2;
	if (NarrativeIndex < 0 || NarrativeIndex > default.PerTurnNarrativeMoments.Length - 1) return ELR_NoInterrupt;

	MissionManager = `TACTICALMISSIONMGR;
	if (MissionManager.ActiveMission.sType != "GP_FortressLeadup") return ELR_NoInterrupt;

	NarrativeContext = XComGameStateContext_FortressNarrative(class'XComGameStateContext_FortressNarrative'.static.CreateXComGameStateContext());
	NarrativeContext.NarrativeIndex = NarrativeIndex;

	`GAMERULES.SubmitGameStateContext(NarrativeContext);

	return ELR_NoInterrupt;
}

defaultproperties
{
	// Copy paste from X2MissionNarrative_DefaultNarrativeSet::AddDefaultAssaultFortressLeadupMissionNarrativeTemplate
	// (but with adjusted indices)
	PerTurnNarrativeMoments[0]="X2NarrativeMoments.T_Final_Mission_First_Set_One";
    PerTurnNarrativeMoments[1]="X2NarrativeMoments.T_Final_Mission_First_Set_Two";
    PerTurnNarrativeMoments[2]="X2NarrativeMoments.T_Final_Mission_First_Set_Three";
    PerTurnNarrativeMoments[3]="X2NarrativeMoments.T_Final_Mission_First_Set_Four";
    PerTurnNarrativeMoments[4]="X2NarrativeMoments.T_Final_Mission_First_Set_Five";
    PerTurnNarrativeMoments[5]="X2NarrativeMoments.T_Final_Mission_First_Set_Six";
    PerTurnNarrativeMoments[6]="X2NarrativeMoments.T_Final_Mission_Middle_Set_One";
    PerTurnNarrativeMoments[7]="X2NarrativeMoments.T_Final_Mission_Middle_Set_Two";
    PerTurnNarrativeMoments[8]="X2NarrativeMoments.T_Final_Mission_Middle_Set_Three";
    PerTurnNarrativeMoments[9]="X2NarrativeMoments.T_Final_Mission_Middle_Set_Four";
}
