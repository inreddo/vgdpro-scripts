VgF={}
vgf=VgF

function VgF.VgCard(c)
    VgD.Rule(c)
    VgF.DefineArguments()
    if c:IsType(TYPE_MONSTER) then
        VgD.RideUp(c)
        VgD.CallToR(c)
        VgD.MonsterBattle(c)
    end
    if not c:IsRace(TRRIGGER_SUPER) then
	    VgD.CardTrigger(c,nil)
    end
end
function GetID()
	local offset=self_code<100000000 and 1 or 100
	return self_table,self_code,offset
end
function VgF.Stringid(code,id)
	return code*16+id
end
function VgF.DefineArguments()
    if not loc then loc=nil end
    if not typ then typ=nil end
    if not count then count=nil end
    if not property then property=nil end
    if not reset then reset=nil end
    if not op then op=nil end
    if not cost then cost=nil end
    if not con then con=nil end
    if not tg then tg=nil end
    if not f then f=nil end
end
function VgF.SequenceToGlobal(p,loc,seq)
	if p~=0 and p~=1 then
		return 0
	end
	if loc==LOCATION_MZONE then
		if seq<=6 then
			return 0x0001<<(16*p+seq)
		else
			return 0
		end
	elseif loc == LOCATION_SZONE then
		if seq<=4 then
			return 0x0100<<(16*p+seq)
		else
			return 0
		end
	else
		return 0
	end
end
function VgF.True()
    return true
end
function VgF.Next(g)
	local first=true
	return	function()
				if first then first=false return g:GetFirst()
				else return g:GetNext() end
			end
end
function VgF.GetValueType(v)
	local t=type(v)
	if t=="userdata" then
		local mt=getmetatable(v)
		if mt==Group then return "Group"
		elseif mt==Effect then return "Effect"
		else return "Card" end
	else return t end
end
function VgF.ReturnCard(g)
    local tc
    if VgF.GetValueType(g)=="Group" then
        tc=g:GetFirst()
    elseif VgF.GetValueType(g)=="Card" then
        tc=g
    end
    return tc
end
function VgF.GetCardsFromGroup(g,num)
    if VgF.GetValueType(g)=="Group" then
        local sg=Group.CreateGroup()
        for tc in VgF.Next(g) do
            if sg:GetCount()>=num then break end
            sg:AddCard(tc)
        end
        return sg
    end
end
bit={}
function bit.band(a,b)
	return a&b
end
function bit.bor(a,b)
	return a|b
end
function bit.bxor(a,b)
	return a~b
end
function bit.lshift(a,b)
	return a<<b
end
function bit.rshift(a,b)
	return a>>b
end
function bit.bnot(a)
	return ~a
end
function VgF.VMonsterFilter(c)
    return VgF.IsSequence(c,5)
end
function VgF.RMonsterFilter(c)
    return c:GetSequence()<5
end
function VgF.RMonsterCondition(e)
    return VgF.RMonsterFilter(e:GetHandler())
end
function VgF.VMonsterCondition(e)
    return VgF.VMonsterFilter(e:GetHandler())
end
function VgF.IsLevel(c,...)
    for i,v in ipairs{...} do
        local lv=v+1
        if c:IsLevel(lv) then
            return true
        end
    end
    return false
end
function VgF.IsSequence(c,...)
    for i,v in ipairs{...} do
        if c:GetSequence()==v then
            return true
        end
    end
    return false
end
function VgF.RuleCardCondtion(e)
    local tp=e:GetHandlerPlayer()
    local g=Duel.GetMatchingGroup(nil,tp,LOCATION_ALL,0,nil)
    return e:GetHandler()==g:GetFirst()
end
function VgF.RuleTurnCondtion(e)
    local tp=e:GetHandlerPlayer()
    local a=Duel.GetTurnCount(tp)
    local b=Duel.GetTurnCount(1-tp)
    return a+b==1
end
function VgF.Not(f)
	return	function(...)
				return not f(...)
			end
end
function VgF.GetColumnGroup(c)
    local tp=c:GetControler()
    local g=Group.CreateGroup()
     if c:GetSequence()==0 then
        local sg1=Duel.GetMatchingGroup(VgF.IsSequence,tp,LOCATION_MZONE,0,nil,1)
        local sg2=Duel.GetMatchingGroup(VgF.IsSequence,tp,0,LOCATION_MZONE,nil,3,4)
        if sg1 then g:Merge(sg1) end
        if sg2 then g:Merge(sg2) end
    end
    if c:GetSequence()==1 then
        local sg1=Duel.GetMatchingGroup(VgF.IsSequence,tp,LOCATION_MZONE,0,nil,0)
        local sg2=Duel.GetMatchingGroup(VgF.IsSequence,tp,0,LOCATION_MZONE,nil,3,4)
        if sg1 then g:Merge(sg1) end
        if sg2 then g:Merge(sg2) end
    end
    if c:GetSequence()==2 then
        local sg1=Duel.GetMatchingGroup(VgF.IsSequence,tp,LOCATION_MZONE,0,nil,5)
        local sg2=Duel.GetMatchingGroup(VgF.IsSequence,tp,0,LOCATION_MZONE,nil,2,5)
        if sg1 then g:Merge(sg1) end
        if sg2 then g:Merge(sg2) end
    end
    if c:GetSequence()==3 then
        local sg1=Duel.GetMatchingGroup(VgF.IsSequence,tp,LOCATION_MZONE,0,nil,4)
        local sg2=Duel.GetMatchingGroup(VgF.IsSequence,tp,0,LOCATION_MZONE,nil,0,1)
        if sg1 then g:Merge(sg1) end
        if sg2 then g:Merge(sg2) end
    end
    if c:GetSequence()==4 then
        local sg1=Duel.GetMatchingGroup(VgF.IsSequence,tp,LOCATION_MZONE,0,nil,3)
        local sg2=Duel.GetMatchingGroup(VgF.IsSequence,tp,0,LOCATION_MZONE,nil,0,1)
        if sg1 then g:Merge(sg1) end
        if sg2 then g:Merge(sg2) end
    end
    if c:GetSequence()==5 then
        local sg1=Duel.GetMatchingGroup(VgF.IsSequence,tp,LOCATION_MZONE,0,nil,2)
        local sg2=Duel.GetMatchingGroup(VgF.IsSequence,tp,0,LOCATION_MZONE,nil,2,5)
        if sg1 then g:Merge(sg1) end
        if sg2 then g:Merge(sg2) end
    end
    return g
end
function VgF.tgoval(e,re,rp)
	return rp==1-e:GetHandlerPlayer()
end
function VgF.Call(g,sumtype,sp,zone)
    if zone then
        if Duel.IsExistingMatchingCard(VgD.CallFilter,sp,LOCATION_MZONE,0,1,nil,sp,zone) then
            local tc=Duel.GetMatchingGroup(VgD.CallFilter,sp,LOCATION_MZONE,0,nil,sp,zone):GetFirst()
            Duel.SendtoGrave(tc,REASON_COST)
        end
	    return Duel.SpecialSummon(g,sumtype,sp,sp,false,false,POS_FACEUP_ATTACK,zone)
    end
    local sg
    local z=0xe0
    if vgf.GetValueType(g)=="Card" then sg=Group.FromCards(g) else sg=Group.Clone(g) end
    for sc in VgF.Next(sg) do
        if sc:IsLocation(LOCATION_EXTRA) then
            local rc=Duel.GetMatchingGroup(VgF.VMonsterFilter,tp,LOCATION_MZONE,0,nil):GetFirst()
            local mg=rc:GetOverlayGroup()
            if mg:GetCount()~=0 then
                Duel.Overlay(sc,mg)
            end
            sc:SetMaterial(Group.FromCards(rc))
            Duel.Overlay(sc,Group.FromCards(rc))
            Duel.SpecialSummonStep(sc,sumtype,sp,sp,false,false,POS_FACEUP_ATTACK,0x20)
        else
            Duel.Hint(HINT_SELECTMSG,sp,HINTMSG_CallZONE)
            local szone=Duel.SelectField(sp,1,LOCATION_MZONE,0,z)
            if Duel.IsExistingMatchingCard(VgD.CallFilter,sp,LOCATION_MZONE,0,1,nil,sp,szone) then
                local tc=Duel.GetMatchingGroup(VgD.CallFilter,sp,LOCATION_MZONE,0,nil,sp,szone):GetFirst()
                Duel.SendtoGrave(tc,REASON_COST)
            end
            Duel.SpecialSummonStep(sc,sumtype,sp,sp,false,false,POS_FACEUP_ATTACK,szone)
            z=bit.bor(z,szone)
        end
    end
    return Duel.SpecialSummonComplete()
end
function VgF.LvCondition(e_or_c)
    local c = VgF.GetValueType(e_or_c) == "Effect" and e_or_c:GetHandler() or e_or_c
    local tp, lv = c:GetControler(), c:GetLevel()
    return Duel.IsExistingMatchingCard(VgF.LvConditionFilter,tp,LOCATION_MZONE,0,1,nil,lv)
end
function VgF.LvConditionFilter(c,lv)
    return VgF.VMonsterFilter(c) and c:IsLevelAbove(lv)
end
function VgF.AtkUp(c,g,val,reset)
    if not c or not g then return end
    if not reset then reset=RESET_PHASE+PHASE_END end
    if not val or val==0 then return end
    if VgF.GetValueType(g)=="Group" and g:GetCount()>0 then
        for tc in VgF.Next(g) do
            local e1=Effect.CreateEffect(c)
            e1:SetType(EFFECT_TYPE_SINGLE)
            e1:SetCode(EFFECT_UPDATE_ATTACK)
            e1:SetValue(val)
            e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset)
            tc:RegisterEffect(e1)
        end
        return
    end
    local tc=VgF.ReturnCard(g)
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetValue(val)
    e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset)
    tc:RegisterEffect(e1)
end
function VgF.StarUp(c,g,val,reset)
    if not c or not g then return end
    if not reset then reset=RESET_PHASE+PHASE_END end
    if not val or val==0 then return end
    if VgF.GetValueType(g)=="Group" and g:GetCount()>0 then
        for tc in VgF.Next(g) do
            local e1=Effect.CreateEffect(c)
            e1:SetType(EFFECT_TYPE_SINGLE)
            e1:SetCode(EFFECT_UPDATE_LSCALE)
            e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
            e1:SetRange(LOCATION_MZONE)
            e1:SetValue(val)
            e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset)
            tc:RegisterEffect(e1)
            local e2=e1:Clone()
            e2:SetCode(EFFECT_UPDATE_RSCALE)
            tc:RegisterEffect(e2)
        end
        return
    end
    local tc=VgF.ReturnCard(g)
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UPDATE_LSCALE)
    e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e1:SetRange(LOCATION_MZONE)
    e1:SetValue(val)
    e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset)
    tc:RegisterEffect(e1)
    local e2=e1:Clone()
    e2:SetCode(EFFECT_UPDATE_RSCALE)
    tc:RegisterEffect(e2)
end
function VgF.IsAbleToGZone(c)
    if c:IsLocation(LOCATION_MZONE) then
        return c:IsAttribute(SKILL_BLOCK)
    end
    return c:IsLocation(LOCATION_HAND)
end
function VgF.DisCardCost(num)
    return function (e,tp,eg,ep,ev,re,r,rp,chk)
        if chk==0 then
            return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,num,nil)
        end
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
        local g=Duel.SelectMatchingCard(tp,Card.IsDiscardable,tp,LOCATION_HAND,0,num,num,nil)
        Duel.SendtoGrave(g,REASON_COST+REASON_DISCARD)
    end
end
function VgF.EnegyCost(num)
    return function (e,tp,eg,ep,ev,re,r,rp,chk)
        if chk==0 then
            return Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_EMBLEM,0,num,nil,10800730)
        end
        local sg=Duel.GetMatchingGroup(tp,Card.IsCode,tp,LOCATION_EMBLEM,0,nil,10800730)
        local g=VgF.GetCardsFromGroup(sg,num)
        Duel.Sendto(g,tp,0,POS_FACEUP,REASON_COST)
    end
end
function VgF.OverlayCost(num)
    return function (e,tp,eg,ep,ev,re,r,rp,chk)
        if chk==0 then
            return Duel.GetMatchingGroup(VgF.VMonsterFilter,tp,LOCATION_MZONE,0,nil,nil):GetFirst():GetOverlayGroup():FilterCount(Card.IsAbleToGraveAsCost,nil)>=num
        end
        local g=Duel.GetMatchingGroup(VgF.VMonsterFilter,tp,LOCATION_MZONE,0,nil):GetFirst():GetOverlayGroup():FilterSelect(tp,Card.IsAbleToGraveAsCost,num,num,nil)
        Duel.SendtoGrave(g,REASON_COST)
    end
end
function VgF.OverlayFillCostOrOperation(num)
    return function (e,tp,eg,ep,ev,re,r,rp,chk)
        if chk==0 then
            return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=num
        end
        local rc=Duel.GetMatchingGroup(VgF.VMonsterFilter,tp,LOCATION_MZONE,0,nil):GetFirst()
        local g=Duel.GetDecktopGroup(tp,num)
        Duel.DisableShuffleCheck()
        Duel.Overlay(rc,g)
    end
end
function VgF.DamageCost(num)
    return function (e,tp,eg,ep,ev,re,r,rp,chk)
        if chk==0 then
            return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_DAMAGE,0,num,nil)
        end
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DAMAGE)
        local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_DAMAGE,0,num,num,nil)
        Duel.ChangePosition(g,POS_FACEDOWN)
    end
end
function VgF.SearchCard(loc,f)
    if not loc then return end
    return function (e,tp,eg,ep,ev,re,r,rp)
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
        local g=Duel.SelectMatchingCard(tp,function (c)
            if VgF.GetValueType(f)=="function" and not f(c) then return false end
            return c:IsAbleToHand()
        end
        ,tp,loc,0,1,1,nil)
        if g:GetCount()>0 then
            Duel.SendtoHand(g,nil,REASON_EFFECT)
            Duel.ConfirmCards(1-tp,g)
        end
    end
end
function VgF.SearchCardSpecialSummon(loc,f)
    if not loc then return end
    return function (e,tp,eg,ep,ev,re,r,rp)
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
        local g=Duel.SelectMatchingCard(tp,function (c)
            if VgF.GetValueType(f)=="function" and not f(c) then return false end
            return c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK)
        end
        ,tp,loc,0,1,1,nil)
        if g:GetCount()>0 then
            if loc&LOCATION_DECK+LOCATION_HAND+LOCATION_EXTRA==0 then Duel.HintSelection(g) end
            VgF.Call(g,0,tp)
        end
    end
end
