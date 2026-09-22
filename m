Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEEF54936E;
	Tue, 22 Sep 2026 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084820; cv=none; b=CDVMOBBTS3K2FyUcYVR1r/8uPMUIiI16QtB9dDiYK8FaMCYbV/sfXwMjR+i+8ku49h6ItLkEyigeXyM4H4nsdrm7igrJPNru4mcNWyNd2MfcNc4oGhMQRhHcC0ylv6jv2ZENmxW6GuNOvVWzWUtXAuYbB2nmbVNRKKDK0XmTucc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084820; c=relaxed/simple;
	bh=fFDOC9T0TFhGt6OOLIbQN//Tf57QuWCEbADZvNpzfuM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=iGAGDqaGX9vUnI2zBDzuIHQGfuHpnza18q8XzFQcKIrv4UGGYT+2JniwdQhkucOX/0vVYrw0pQtpuUhV1qYOhccRFa11Ysd0l3kRSmawNfG2v+oQXFoZWAmnkEuQCPWtvjuT6iJ2gSyxRaVerinzcIAL11zL+658sC25jm2KCns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=jeIJ+Ynk; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="jeIJ+Ynk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=2XHBwmitdcazAFEXQmp0ZNTPvrwOOlTd0HKwfxKvijg=; b=jeIJ+YnkJim6UaUNMK2FL6JrL7
	OsCIbfnb1eLRrXKN6dmPoLxzDhcukwIfXjrYHTEgvB4JsQUJBMrsrYorWDPvYdMAyYwFMRm3TTUUZ
	yBIFEcNLPLm/avHRAOQQylVcLZ3Bpef+Iptbi+GcfnnUIaH+y6D6Z1O1UA+MedJ6xyKLi6LpFba4a
	pUu1OYj/xYlKx/pvRo5NeNTn3LanTwFJidXzwVs6SKfjFUIju3lI6qQsh9MBM1nHMGGaIKufqDkse
	zf8NcuHR6OfA3/R2sVUCm4/Px+kjrWm1QuH9ri7XNjE5f+LDubBAtCdT+/jXqyxwazIYADe0UEJDT
	6i4sRSAw==;
Received: from [::1] (port=33148 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1x90pk-00000003tv9-0WZn;
	Tue, 22 Sep 2026 15:46:55 +0200
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 15:46:55 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
 audit@vger.kernel.org, linux-kernel@vger.kernel.org, Bradley Morgan
 <brads@mainlining.org>
Subject: Re: [PATCH] audit: fix exe mark UAF in kill_rules()
In-Reply-To: <CAABTaaC+vZmvg6s26oaYzkmnEvR42ZYcXutKfVNAa8VsK5ApDw@mail.gmail.com>
References: <20260921195921.4174830-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <CAABTaaC+vZmvg6s26oaYzkmnEvR42ZYcXutKfVNAa8VsK5ApDw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <e4872a4b49c279e792adb228281d1513@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-09-22 13:26, Ricardo Robaina wrote:
> On Mon, Sep 21, 2026 at 5:07 PM Jérémy Jean
> <Jeremy.Jean@oss.cyber.gouv.fr> wrote:
>> 
>> kill_rules() removes mixed AUDIT_DIR and AUDIT_EXE rules when an audit
>> tree is pruned. It drops entry->rule.exe before removing the rule from
>> the RCU-visible filter lists.
>> 
>> After a rule has been installed with AUDIT_ADD_RULE, which requires
>> CAP_AUDIT_CONTROL, removing or moving the watched directory can race
>> with another task that is still evaluating the rule. In that case,
>> fsnotify can free the executable mark before the reader reaches
>> audit_mark_compare(), causing a use-after-free.
>> 
>> KASAN reports:
>> 
>>     BUG: KASAN: slab-use-after-free in audit_mark_compare+0x8d/0xa0
>> 
>> Remove the rule from the RCU-visible filter lists first, wait for a 
>> grace
>> period, and only then drop the executable mark. audit_del_rule() 
>> already
>> uses this ordering.
>> 
>> Fixes: 34d99af52ad4 ("audit: implement audit by executable")
>> Assisted-by: Codex:gpt-5
>> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>> ---
>>  kernel/audit_tree.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
>> index 1ed19b7..864a58b 100644
>> --- a/kernel/audit_tree.c
>> +++ b/kernel/audit_tree.c
>> @@ -553,11 +553,12 @@ static void kill_rules(struct audit_context 
>> *context, struct audit_tree *tree)
>>                 if (rule->tree) {
>>                         /* not a half-baked one */
>>                         audit_tree_log_remove_rule(context, rule);
>> -                       if (entry->rule.exe)
>> -                               audit_remove_mark(entry->rule.exe);
>>                         rule->tree = NULL;
>>                         list_del_rcu(&entry->list);
>>                         list_del(&entry->rule.list);
>> +                       synchronize_rcu();
>> +                       if (entry->rule.exe)
>> +                               audit_remove_mark(entry->rule.exe);
>>                         call_rcu(&entry->rcu, audit_free_rule_rcu);
>>                 }
>>         }
>> --
>> 2.47.3
>> 
>> 
> 
> Hi Jérémy,
> 
> Thanks for troubleshooting and fixing this bug.
> 
> sashiko's review makes sense, though: synchronize_rcu() inside the
> loop waits a full grace period per rule, and kill_rules() runs with
> audit_filter_mutex held, so a tree with many rules stalls other audit
> config operations. Below is an untested suggestion to use a single
> grace period instead.
> 
> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> index 1ed19b775912..5a3d7c7ba5ce 100644
> --- a/kernel/audit_tree.c
> +++ b/kernel/audit_tree.c
> @@ -549,18 +549,30 @@ static void kill_rules(struct audit_context
> *context, struct audit_tree *tree)
>         list_for_each_entry_safe(rule, next, &tree->rules, rlist) {
>                 entry = container_of(rule, struct audit_entry, rule);
> 
> -               list_del_init(&rule->rlist);
>                 if (rule->tree) {
>                         /* not a half-baked one */
>                         audit_tree_log_remove_rule(context, rule);
> -                       if (entry->rule.exe)
> -                               audit_remove_mark(entry->rule.exe);
>                         rule->tree = NULL;
>                         list_del_rcu(&entry->list);
>                         list_del(&entry->rule.list);
> -                       call_rcu(&entry->rcu, audit_free_rule_rcu);
> +               } else {
> +                       list_del_init(&rule->rlist);
>                 }
>         }
> +
> +       if (list_empty(&tree->rules))
> +               return;
> +
> +       synchronize_rcu();
> +
> +       list_for_each_entry_safe(rule, next, &tree->rules, rlist) {
> +               entry = container_of(rule, struct audit_entry, rule);
> +
> +               list_del_init(&rule->rlist);
> +               if (entry->rule.exe)
> +                       audit_remove_mark(entry->rule.exe);
> +               call_rcu(&entry->rcu, audit_free_rule_rcu);
> +       }
>  }
> 
>  /*

Hello Ricardo,

Many thanks for your nice and constructive answer.

Indeed, sashiko's review makes sense and your suggested v2 is a good 
fix.
I have replayed my reproducer to ensure that it indeeds fix the reported 
bug.

However, I wonder whether the wait should still happen in the case where
all removed rules have rule->exe == NULL. Doesn't call_rcu() already
free (kernel/auditfilter.c:96)?  If yes, could we skip synchronize_rcu() 
in
that case? If this question is valid, how about this fix based on yours, 
which
simply adds a bool to detect whether synchronize_rcu() should be called.

If you think this addition is good, I can send a v2 with that.

diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index 1ed19b775912..e2cd27b17590 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -545,22 +545,38 @@ static void kill_rules(struct audit_context 
*context, struct audit_tree *tree)
  {
         struct audit_krule *rule, *next;
         struct audit_entry *entry;
+       bool need_sync = false;

         list_for_each_entry_safe(rule, next, &tree->rules, rlist) {
                 entry = container_of(rule, struct audit_entry, rule);

-               list_del_init(&rule->rlist);
                 if (rule->tree) {
                         /* not a half-baked one */
                         audit_tree_log_remove_rule(context, rule);
-                       if (entry->rule.exe)
-                               audit_remove_mark(entry->rule.exe);
                         rule->tree = NULL;
                         list_del_rcu(&entry->list);
                         list_del(&entry->rule.list);
-                       call_rcu(&entry->rcu, audit_free_rule_rcu);
+                       if (rule->exe)
+                               need_sync = true;
+               } else {
+                       list_del_init(&rule->rlist);
                 }
         }
+
+       if (list_empty(&tree->rules))
+               return;
+
+       if (need_sync)
+               synchronize_rcu();
+
+       list_for_each_entry_safe(rule, next, &tree->rules, rlist) {
+               entry = container_of(rule, struct audit_entry, rule);
+
+               list_del_init(&rule->rlist);
+               if (entry->rule.exe)
+                       audit_remove_mark(entry->rule.exe);
+               call_rcu(&entry->rcu, audit_free_rule_rcu);
+       }
  }

  /*

Regards,
Jérémy
