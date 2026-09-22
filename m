Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7E953B325
	for <audit@vger.kernel.org>; Tue, 22 Sep 2026 11:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790076400; cv=none; b=Zj1nr+MP3EcAg+4sUdVRxxH2OZ3vP+voOiAu93Sl7YZhjiB3GsvNEYxASZVMNtBPdRUBCvp6b6dcjdFH5yuLUUNlnS991Zrnhl5CaHUG4hFO42RTbpeY7CbHlBbEfhhviBXa6i3EAG4M62vBKiW/2CVKk638tzqi7LnbjOJLk5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790076400; c=relaxed/simple;
	bh=EnAulzdwZZUNacsSO5JAqAI8aWy+2MWOn3g0jZUFmBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCJjgq9NQFv5XwLxlzjQm79k4Cw2vufaBPisTx8qL8J2oAUtfccQxqiaz4a4/pNl7Nl5UEZ4yAdld0GiSSMAk/8ahWm99DNmtgEiWybSxUu0izw8piLiqafcFOCTgMIl0PThkExoZqfoCiVyG7WUVCSGEUWivK/7SEgLqcMwFtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IoMC5nPT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoMC5nPT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790076394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wiSOuYwJYI5AO9B2WqiuxGZ3NuSU54y3F1+XGq/C0HE=;
	b=IoMC5nPTJ/YMFnKJMClPNupt4EwO10fSCFMkWgiYPnMK2IPQUmkL1sd/fW9DI9uWUcQqJ9
	4r7W+OHNALhXyvbo5LPsDQsT6jXzddJSUEvMjs7NfDTRFLJ1C5qBI2F35Q+5B7nzjg3bk4
	YKW85T+eEoWRM1Ijl+5VzU4b2Of5KC4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-ShoUQURUOxmkygc4lqTXKQ-1; Tue, 22 Sep 2026 07:26:33 -0400
X-MC-Unique: ShoUQURUOxmkygc4lqTXKQ-1
X-Mimecast-MFC-AGG-ID: ShoUQURUOxmkygc4lqTXKQ_1790076392
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c294442d71dso481901166b.2
        for <audit@vger.kernel.org>; Tue, 22 Sep 2026 04:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790076392; x=1790681192;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wiSOuYwJYI5AO9B2WqiuxGZ3NuSU54y3F1+XGq/C0HE=;
        b=1M6se37879gfFVHXLG89G8COpEkGZAQXf0jpYOMbmgLhPt8MWpCMiqq50aR3helIRa
         dm0m0uKQGPGsOn8HQXTqFTowjc5GElrWrbxWJ3X4a5+lZx2GQbxh/ibIflMDZpysekgJ
         HCs4HtqwBsNim+dWqMzCfIhulXTedXZDFPfdnQddfxfIzu9Ad7V6+BAo3kbvg90yz8zX
         yz6DHYJgK8KX4WezUofpxL7eNXwm2WEh1nJ/EqNJeXSzXo4Lh6ZEgmP7KJOqEdbwwE3r
         vDmqu11l6/ULlYkKq9wKouTVVVm4qakotIz7lHhnsh9MCA3AC4iZTno4VYhS3hRzhIUp
         5LTQ==
X-Forwarded-Encrypted: i=1; AKwUvBxjgs9GazCd703kqBsOIYZwvtUecq6ZVHIy0xpQVZbB2g2bmAJOLd8OoK28VsAmSbnbjd6/9Q==@vger.kernel.org
X-Gm-Message-State: AFuF++ml17Du1VdIYJxPLpXav0W1iuiQXDH9zvTp0WNjE5FTY5WqiV2B
	JqXRkq075P7Y0XKbjKTKRNev47JoawgXN3fUKuVSjoQZ1F90jIvI9i9dHvMvG4vqH7F/PYjnVj9
	HgX20jrCqisZK2Vtd1Mj3LGRJZXeUCaUUPFPT7hkx/r2tQ222gJqXWv+VkX3ux+5nLUiv65Z9PB
	Zk6X4hQzAWZCG4qxXYECSGfoxJPvgznNoQnqovu8YBfg==
X-Gm-Gg: AYBFou1sMuLifAnEmKU7fSrqAAIvyZr1Mwa4HmT795grbVOu7yTu/Acqdk9vnj5UARp
	hmJywCojFIbdu+sayQBmwBUKRi+o3+V2EM1NQkqMVEanfWP3m6BO7eNdkR7FxRtujj//f4QBT1L
	0wBUyVjBK3AWPop79uNeh2nJCD7PJ2GySbYVSRA25B/YM0XluSmGOPfhtGeChBtzV8HMQi+tmom
	jiuIC7QwoVMpkLtxpmkd41UzTeyU2MHxd8RPecLhIB8hzQSU9EWJD6+cDGzDe0BA9/issrh1ghz
	GBo=
X-Received: by 2002:a17:906:ba89:b0:c29:5151:16b8 with SMTP id a640c23a62f3a-c2a1581803amr1046226966b.2.1790076392129;
        Tue, 22 Sep 2026 04:26:32 -0700 (PDT)
X-Received: by 2002:a17:906:ba89:b0:c29:5151:16b8 with SMTP id
 a640c23a62f3a-c2a1581803amr1046225866b.2.1790076391733; Tue, 22 Sep 2026
 04:26:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921195921.4174830-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20260921195921.4174830-2-Jeremy.Jean@oss.cyber.gouv.fr>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Tue, 22 Sep 2026 08:26:20 -0300
X-Gm-Features: AcwNN1WFPYCIYdQMnG0J7f9SFhSPclnojOnaux6VqF9_nV_yNTRTszbi0d-qIZI
Message-ID: <CAABTaaC+vZmvg6s26oaYzkmnEvR42ZYcXutKfVNAa8VsK5ApDw@mail.gmail.com>
Subject: Re: [PATCH] audit: fix exe mark UAF in kill_rules()
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GdGHMy4GnnqAzd1YX08ycI04ruxjic7czA-B_yK-jXY_1790076392
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 5:07=E2=80=AFPM J=C3=A9r=C3=A9my Jean
<Jeremy.Jean@oss.cyber.gouv.fr> wrote:
>
> kill_rules() removes mixed AUDIT_DIR and AUDIT_EXE rules when an audit
> tree is pruned. It drops entry->rule.exe before removing the rule from
> the RCU-visible filter lists.
>
> After a rule has been installed with AUDIT_ADD_RULE, which requires
> CAP_AUDIT_CONTROL, removing or moving the watched directory can race
> with another task that is still evaluating the rule. In that case,
> fsnotify can free the executable mark before the reader reaches
> audit_mark_compare(), causing a use-after-free.
>
> KASAN reports:
>
>     BUG: KASAN: slab-use-after-free in audit_mark_compare+0x8d/0xa0
>
> Remove the rule from the RCU-visible filter lists first, wait for a grace
> period, and only then drop the executable mark. audit_del_rule() already
> uses this ordering.
>
> Fixes: 34d99af52ad4 ("audit: implement audit by executable")
> Assisted-by: Codex:gpt-5
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>  kernel/audit_tree.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> index 1ed19b7..864a58b 100644
> --- a/kernel/audit_tree.c
> +++ b/kernel/audit_tree.c
> @@ -553,11 +553,12 @@ static void kill_rules(struct audit_context *contex=
t, struct audit_tree *tree)
>                 if (rule->tree) {
>                         /* not a half-baked one */
>                         audit_tree_log_remove_rule(context, rule);
> -                       if (entry->rule.exe)
> -                               audit_remove_mark(entry->rule.exe);
>                         rule->tree =3D NULL;
>                         list_del_rcu(&entry->list);
>                         list_del(&entry->rule.list);
> +                       synchronize_rcu();
> +                       if (entry->rule.exe)
> +                               audit_remove_mark(entry->rule.exe);
>                         call_rcu(&entry->rcu, audit_free_rule_rcu);
>                 }
>         }
> --
> 2.47.3
>
>

Hi J=C3=A9r=C3=A9my,

Thanks for troubleshooting and fixing this bug.

sashiko's review makes sense, though: synchronize_rcu() inside the
loop waits a full grace period per rule, and kill_rules() runs with
audit_filter_mutex held, so a tree with many rules stalls other audit
config operations. Below is an untested suggestion to use a single
grace period instead.

diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index 1ed19b775912..5a3d7c7ba5ce 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -549,18 +549,30 @@ static void kill_rules(struct audit_context
*context, struct audit_tree *tree)
        list_for_each_entry_safe(rule, next, &tree->rules, rlist) {
                entry =3D container_of(rule, struct audit_entry, rule);

-               list_del_init(&rule->rlist);
                if (rule->tree) {
                        /* not a half-baked one */
                        audit_tree_log_remove_rule(context, rule);
-                       if (entry->rule.exe)
-                               audit_remove_mark(entry->rule.exe);
                        rule->tree =3D NULL;
                        list_del_rcu(&entry->list);
                        list_del(&entry->rule.list);
-                       call_rcu(&entry->rcu, audit_free_rule_rcu);
+               } else {
+                       list_del_init(&rule->rlist);
                }
        }
+
+       if (list_empty(&tree->rules))
+               return;
+
+       synchronize_rcu();
+
+       list_for_each_entry_safe(rule, next, &tree->rules, rlist) {
+               entry =3D container_of(rule, struct audit_entry, rule);
+
+               list_del_init(&rule->rlist);
+               if (entry->rule.exe)
+                       audit_remove_mark(entry->rule.exe);
+               call_rcu(&entry->rcu, audit_free_rule_rcu);
+       }
 }

 /*

--Ricardo

