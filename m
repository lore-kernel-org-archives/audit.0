Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024823D348C;
	Tue, 22 Sep 2026 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089758; cv=none; b=LU9eGoSz89KWKTLT8RVIf54fa8FZBMB+k4HHN9FJkKd2fUosRWOvSUZHvdCTNHlry5qhgfZZPM0ZTiNa6r2sc5CaRG4RkSs2VlR6ROWplocOn8Y4pp7cLiUuBULeItpwztkhIhCaPg//CkOolV6xhAq5V4XGKR5ZlqPqFs3Sg4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089758; c=relaxed/simple;
	bh=tQZ6+lpotfNYppShc26CXimpNOk/SKRnqms9adBfFfs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=uQdXvifIdhJAoTir1M9eaZgutmx9zQCG7W7W/5GKz5dAAVfzNh4Ke4N0Zr95swia5ll+9TYNCeapCqwOzcf3lAXKA1Mas0NfQIDaK14utqUi0TfYWwEZFEPQ8r/YAbyiqEp93bzNMlIJp07K8gyAiTWyA6pVtrCumpv9Ax5pAvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=i1L8vno+; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=yFJXcWla; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="i1L8vno+";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="yFJXcWla"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790089707; bh=D4AtkvFA3il1JL3usmeC6+p
	lRFcaroVqvV8OHCek2OA=; b=i1L8vno+jsevWvLrpPZQPORFU85T6H3zKpuT+aJWvlIxFdSNLK
	asexkUvA2mHcLROZde6tJqeA3cYkj3JPjk6O9yPydCyRmrnkD4HnWyk1nTTfFiJJ+SHFA52Affz
	55UxyQw1tExC1W+HOAhHXZsLyN4R7GVuFEK5BhrCpIuX3Q49gfL7nnhIjJpIIhE+f1hAtaoH1n4
	GM/2x1fL2VlTDAF3PKEQmJyG0N2q3FwGC1pbYFJptSI1iigL+OI6hVn5E+eIYtEKu6QwLHjGyPu
	uOv6kiAZQkOjmvfUYMW++klMRk20UpjdbMJgaE+okkwL0j/a59tj4+zVVo9a/tVhMig==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790089707; bh=D4AtkvFA3il1JL3usmeC6+p
	lRFcaroVqvV8OHCek2OA=; b=yFJXcWlaPIcdob9Dydhu9NF41g3sR0zuoNihw9E7/EiHNnyF75
	gOPpxAMDa/3Lk04+t4uWH/lDe7sBLBkYPTCA==;
Date: Tue, 22 Sep 2026 16:08:28 +0100
From: Bradley Morgan <brads@mainlining.org>
To: =?ISO-8859-1?Q?J=E9r=E9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>,
 Ricardo Robaina <rrobaina@redhat.com>
CC: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
 audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] audit: fix exe mark UAF in kill_rules()
In-Reply-To: <e4872a4b49c279e792adb228281d1513@oss.cyber.gouv.fr>
References: <20260921195921.4174830-2-Jeremy.Jean@oss.cyber.gouv.fr> <CAABTaaC+vZmvg6s26oaYzkmnEvR42ZYcXutKfVNAa8VsK5ApDw@mail.gmail.com> <e4872a4b49c279e792adb228281d1513@oss.cyber.gouv.fr>
Message-ID: <EFB280AE-6333-4F17-A9CE-45D8B2C1C64E@mainlining.org>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 22 September 2026 14:46:55 BST, "Jérémy Jean"
<jeremy.jean@oss.cyber.gouv.fr> wrote:
>On 2026-09-22 13:26, Ricardo Robaina wrote:
>> On Mon, Sep 21, 2026 at 5:07 PM Jérémy Jean
>> <Jeremy.Jean@oss.cyber.gouv.fr> wrote:
>>> 
>>> kill_rules() removes mixed AUDIT_DIR and AUDIT_EXE rules when an audit
>>> tree is pruned. It drops entry->rule.exe before removing the rule from
>>> the RCU-visible filter lists.
>>> 
>>> After a rule has been installed with AUDIT_ADD_RULE, which requires
>>> CAP_AUDIT_CONTROL, removing or moving the watched directory can race
>>> with another task that is still evaluating the rule. In that case,
>>> fsnotify can free the executable mark before the reader reaches
>>> audit_mark_compare(), causing a use-after-free.
>>> 
>>> KASAN reports:
>>> 
>>>     BUG: KASAN: slab-use-after-free in audit_mark_compare+0x8d/0xa0
>>> 
>>> Remove the rule from the RCU-visible filter lists first, wait for a
>grace
>>> period, and only then drop the executable mark. audit_del_rule()
>already
>>> uses this ordering.
>>> 
>>> Fixes: 34d99af52ad4 ("audit: implement audit by executable")
>>> Assisted-by: Codex:gpt-5
>>> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>>> ---
>>>  kernel/audit_tree.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
>>> index 1ed19b7..864a58b 100644
>>> --- a/kernel/audit_tree.c
>>> +++ b/kernel/audit_tree.c
>>> @@ -553,11 +553,12 @@ static void kill_rules(struct audit_context
>*context, struct audit_tree *tree)
>>>                 if (rule->tree) {
>>>                         /* not a half-baked one */
>>>                         audit_tree_log_remove_rule(context, rule);
>>> -                       if (entry->rule.exe)
>>> -                               audit_remove_mark(entry->rule.exe);
>>>                         rule->tree = NULL;
>>>                         list_del_rcu(&entry->list);
>>>                         list_del(&entry->rule.list);
>>> +                       synchronize_rcu();
>>> +                       if (entry->rule.exe)
>>> +                               audit_remove_mark(entry->rule.exe);
>>>                         call_rcu(&entry->rcu, audit_free_rule_rcu);
>>>                 }
>>>         }
>>> --
>>> 2.47.3
>>> 
>>> 
>> 
>> Hi Jérémy,
>> 
>> Thanks for troubleshooting and fixing this bug.
>> 
>> sashiko's review makes sense, though: synchronize_rcu() inside the
>> loop waits a full grace period per rule, and kill_rules() runs with
>> audit_filter_mutex held, so a tree with many rules stalls other audit
>> config operations. Below is an untested suggestion to use a single
>> grace period instead.
>> 
>> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
>> index 1ed19b775912..5a3d7c7ba5ce 100644
>> --- a/kernel/audit_tree.c
>> +++ b/kernel/audit_tree.c
>> @@ -549,18 +549,30 @@ static void kill_rules(struct audit_context
>> *context, struct audit_tree *tree)
>>         list_for_each_entry_safe(rule, next, &tree->rules, rlist) {
>>                 entry = container_of(rule, struct audit_entry, rule);
>> 
>> -               list_del_init(&rule->rlist);
>>                 if (rule->tree) {
>>                         /* not a half-baked one */
>>                         audit_tree_log_remove_rule(context, rule);
>> -                       if (entry->rule.exe)
>> -                               audit_remove_mark(entry->rule.exe);
>>                         rule->tree = NULL;
>>                         list_del_rcu(&entry->list);
>>                         list_del(&entry->rule.list);
>> -                       call_rcu(&entry->rcu, audit_free_rule_rcu);
>> +               } else {
>> +                       list_del_init(&rule->rlist);
>>                 }
>>         }
>> +
>> +       if (list_empty(&tree->rules))
>> +               return;
>> +
>> +       synchronize_rcu();
>> +
>> +       list_for_each_entry_safe(rule, next, &tree->rules, rlist) {
>> +               entry = container_of(rule, struct audit_entry, rule);
>> +
>> +               list_del_init(&rule->rlist);
>> +               if (entry->rule.exe)
>> +                       audit_remove_mark(entry->rule.exe);
>> +               call_rcu(&entry->rcu, audit_free_rule_rcu);
>> +       }
>>  }
>> 
>>  /*
>
>Hello Ricardo,
>
>Many thanks for your nice and constructive answer.
>
>Indeed, sashiko's review makes sense and your suggested v2 is a good fix.
>I have replayed my reproducer to ensure that it indeeds fix the reported
>bug.
>
>However, I wonder whether the wait should still happen in the case where
>all removed rules have rule->exe == NULL. Doesn't call_rcu() already
>free (kernel/auditfilter.c:96)?  If yes, could we skip synchronize_rcu()
>in
>that case? If this question is valid, how about this fix based on yours,
>which
>simply adds a bool to detect whether synchronize_rcu() should be called.
>
>If you think this addition is good, I can send a v2 with that.
>
>diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
>index 1ed19b775912..e2cd27b17590 100644
>--- a/kernel/audit_tree.c
>+++ b/kernel/audit_tree.c
>@@ -545,22 +545,38 @@ static void kill_rules(struct audit_context *context, struct audit_tree *tree)
> {
>        struct audit_krule *rule, *next;
>        struct audit_entry *entry;
>+       bool need_sync = false;
>
>        list_for_each_entry_safe(rule, next, &tree->rules, rlist) {
>                entry = container_of(rule, struct audit_entry, rule);
>
>-               list_del_init(&rule->rlist);
>                if (rule->tree) {
>                        /* not a half-baked one */
>                        audit_tree_log_remove_rule(context, rule);
>-                       if (entry->rule.exe)
>-                               audit_remove_mark(entry->rule.exe);
>                        rule->tree = NULL;
>                        list_del_rcu(&entry->list);
>                        list_del(&entry->rule.list);
>-                       call_rcu(&entry->rcu, audit_free_rule_rcu);
>+                       if (rule->exe)
>+                               need_sync = true;
>+               } else {
>+                       list_del_init(&rule->rlist);
>                }
>        }
>+
>+       if (list_empty(&tree->rules))
>+               return;
>+
>+       if (need_sync)
>+               synchronize_rcu();
>+
>+       list_for_each_entry_safe(rule, next, &tree->rules, rlist) {
>+               entry = container_of(rule, struct audit_entry, rule);
>+
>+               list_del_init(&rule->rlist);
>+               if (entry->rule.exe)
>+                       audit_remove_mark(entry->rule.exe);
>+               call_rcu(&entry->rcu, audit_free_rule_rcu);
>+       }
> }
>
> /*

LGTM!

Reviewed-by: Bradley Morgan <brads@mainlining.org>


What do you reckon Ricardo?


>
>Regards,
>Jérémy

--- Thanks!
"I'm not a very positive person" - Linus torvalds
