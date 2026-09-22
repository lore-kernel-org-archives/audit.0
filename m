Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05233A1693
	for <audit@vger.kernel.org>; Tue, 22 Sep 2026 20:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107666; cv=none; b=Nm5RVQZw7Y0jELYhjcJAawleXqU+6Etln1YzKhyM5l2z4/WbA3dxqEGh0nZxPwhv5x37nidudL+98ix2p2r9j14r1rPIQvYmq7XVq6hs/805+/hCrajs9g3Hyi8d+oH8EGCO1y+qeIv0igcAPVlIIHSCpEmsC5N6sWJNCnaxKWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107666; c=relaxed/simple;
	bh=SrJaGHHbv8gk4RfxUwzPYTQZYzC3ejgqVQBh7or0lxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D62nBbtNOXPeOO+nVQyF1cVBmItc1ehiA+ZlwzGYWTuxjRu8xWev2DRFk140cnuKdpNNXr4AoRbCLvmnOTm+9tgDQeesYLjoEv3WmDccrDmvQR5j2vw+n9Sg/q0YtsYcun7qGzwibrenyJswMukkh+2HB7wIn5LcYYZHe8ylwLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nw5XqFpF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nw5XqFpF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790107644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qyOXKWFvSris2DY7q+sIhRXpq5TeCWL3zaIqbcp2AzA=;
	b=Nw5XqFpFlnCw5m56iezsMcDyGMBUNbyjnXbloFHXYKd/VwFUi9R4+lrqE4l0G5L/6eA5nY
	ezQLBaLjefDUtXUF2y8Ww3zhHV5nVwb1XT/ndd2wbt/LlZVQINdUz5u9o87InWvQ3EvM3+
	actWM9is5bvFP/nuQ5qbmSDZAo/3eUE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-bUMRVROjOSOLkIvK0Obdrw-1; Tue, 22 Sep 2026 16:07:22 -0400
X-MC-Unique: bUMRVROjOSOLkIvK0Obdrw-1
X-Mimecast-MFC-AGG-ID: bUMRVROjOSOLkIvK0Obdrw_1790107641
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c251c140b41so13227266b.3
        for <audit@vger.kernel.org>; Tue, 22 Sep 2026 13:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790107641; x=1790712441;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qyOXKWFvSris2DY7q+sIhRXpq5TeCWL3zaIqbcp2AzA=;
        b=LzNA02yJxsHIIG58iCdjvSmkDVjsd2oL3kcY9Xv1Y0yeBeseZBVFgcj0/DhxW1f1H5
         2PII7YA1pDTYcORLNVnuxKWcvwoTluFQLsI337AyAgMvKSJmgMrm3Rf3DojZqGd7NZPk
         ZoX92lYoNgqlfIYnoOXNuF++exq0xgMzJDdKBvMVtXsTy+RCzsRd6h7h8WdvXG2lUo2z
         YSyHZOrGewVDZXLeS/ILv0sggW44wWr+UWNIOOLjusRQjpQXG9mL5wSbYmAGAb6QSWUh
         3c4baYINSvXRExR+I6TxG87h9z9PT/DiqENf5YwE6VAQqrUJ7lXTkYRWE9nlowN8Z5L+
         YDIA==
X-Forwarded-Encrypted: i=1; AKwUvBx7I3FSi1AiogaDSlnYmC5sA/GvNJkpNQgKJtfX+4ZFrgMsR95xx5hnAmnoZ6huyVpUpXjjcw==@vger.kernel.org
X-Gm-Message-State: AFuF++l4nYG4oftXN/g/epBm+a+J8KhaIqdnFcv9OT7ByV3nbMiAL6e6
	J+SMU3WgVyioL7mFyawZOULOVPOQX8iO73VoLCRvHzwmfm0EUfa0FCvDKZzPLPKZHADWrrIQjWy
	lcPuh2KxiMJlbyMi9mF+51OL4GHc6EJOOkbbifMGlixio4tEsGYEAxAvmL7xaxR7sg7d6slWcI6
	8whK+49q+i32n0jlTuKkzJ44IpYy1FVLE=
X-Gm-Gg: AYBFou1L+JlO7W3PQKwPWrmkS8cEt5XxVevmw2Q/my4VKp3HWoZS5kXh1KzD02M6ENk
	4VO4gHqk66c9DjgUlU3W4KEnaKy47bqUird5p6/CtCiGzaxN1RDZGo0e4DuYlyhSQjfrUzIonwt
	71lJEHkJjp8mpF8FG6+0tUvCR4biAy3f0w8zpIkv5H6pmUH9JRugbCjYDSjl2990lRvxP+Hdr/x
	itYvAc9fH0i2TW2z9TY5WhcRIP0I0GDFRg5O8aY0L5691tY+IPCa/BStlbt4x3MARrTEqIWE6uP
	4DA=
X-Received: by 2002:a17:907:3e91:b0:c24:6445:d19 with SMTP id a640c23a62f3a-c2aadf138d9mr32188966b.17.1790107641281;
        Tue, 22 Sep 2026 13:07:21 -0700 (PDT)
X-Received: by 2002:a17:907:3e91:b0:c24:6445:d19 with SMTP id
 a640c23a62f3a-c2aadf138d9mr32187066b.17.1790107640870; Tue, 22 Sep 2026
 13:07:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921195921.4174830-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <CAABTaaC+vZmvg6s26oaYzkmnEvR42ZYcXutKfVNAa8VsK5ApDw@mail.gmail.com> <e4872a4b49c279e792adb228281d1513@oss.cyber.gouv.fr>
In-Reply-To: <e4872a4b49c279e792adb228281d1513@oss.cyber.gouv.fr>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Tue, 22 Sep 2026 17:07:08 -0300
X-Gm-Features: AclHuK__KqL1ADBhQwjfIgYv1YfYiX7v6X14rqvorp2ogNXHNUGZYZtWa0wta80
Message-ID: <CAABTaaA3A34wWdaWbQaSxepDtwZk9_UsV1ihjEXM3kcfYVQ5hA@mail.gmail.com>
Subject: Re: [PATCH] audit: fix exe mark UAF in kill_rules()
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <jeremy.jean@oss.cyber.gouv.fr>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bradley Morgan <brads@mainlining.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FvEJb2Fiu67q4FgqvxZjlRWVBfySEN-zIAevk3cQW-w_1790107641
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 10:47=E2=80=AFAM J=C3=A9r=C3=A9my Jean
<jeremy.jean@oss.cyber.gouv.fr> wrote:
>
> On 2026-09-22 13:26, Ricardo Robaina wrote:
> > On Mon, Sep 21, 2026 at 5:07=E2=80=AFPM J=C3=A9r=C3=A9my Jean
> > <Jeremy.Jean@oss.cyber.gouv.fr> wrote:
> >>
> >> kill_rules() removes mixed AUDIT_DIR and AUDIT_EXE rules when an audit
> >> tree is pruned. It drops entry->rule.exe before removing the rule from
> >> the RCU-visible filter lists.
> >>
> >> After a rule has been installed with AUDIT_ADD_RULE, which requires
> >> CAP_AUDIT_CONTROL, removing or moving the watched directory can race
> >> with another task that is still evaluating the rule. In that case,
> >> fsnotify can free the executable mark before the reader reaches
> >> audit_mark_compare(), causing a use-after-free.
> >>
> >> KASAN reports:
> >>
> >>     BUG: KASAN: slab-use-after-free in audit_mark_compare+0x8d/0xa0
> >>
> >> Remove the rule from the RCU-visible filter lists first, wait for a
> >> grace
> >> period, and only then drop the executable mark. audit_del_rule()
> >> already
> >> uses this ordering.
> >>
> >> Fixes: 34d99af52ad4 ("audit: implement audit by executable")
> >> Assisted-by: Codex:gpt-5
> >> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> >> ---
> >>  kernel/audit_tree.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> >> index 1ed19b7..864a58b 100644
> >> --- a/kernel/audit_tree.c
> >> +++ b/kernel/audit_tree.c
> >> @@ -553,11 +553,12 @@ static void kill_rules(struct audit_context
> >> *context, struct audit_tree *tree)
> >>                 if (rule->tree) {
> >>                         /* not a half-baked one */
> >>                         audit_tree_log_remove_rule(context, rule);
> >> -                       if (entry->rule.exe)
> >> -                               audit_remove_mark(entry->rule.exe);
> >>                         rule->tree =3D NULL;
> >>                         list_del_rcu(&entry->list);
> >>                         list_del(&entry->rule.list);
> >> +                       synchronize_rcu();
> >> +                       if (entry->rule.exe)
> >> +                               audit_remove_mark(entry->rule.exe);
> >>                         call_rcu(&entry->rcu, audit_free_rule_rcu);
> >>                 }
> >>         }
> >> --
> >> 2.47.3
> >>
> >>
> >
> > Hi J=C3=A9r=C3=A9my,
> >
> > Thanks for troubleshooting and fixing this bug.
> >
> > sashiko's review makes sense, though: synchronize_rcu() inside the
> > loop waits a full grace period per rule, and kill_rules() runs with
> > audit_filter_mutex held, so a tree with many rules stalls other audit
> > config operations. Below is an untested suggestion to use a single
> > grace period instead.
> >
> > diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> > index 1ed19b775912..5a3d7c7ba5ce 100644
> > --- a/kernel/audit_tree.c
> > +++ b/kernel/audit_tree.c
> > @@ -549,18 +549,30 @@ static void kill_rules(struct audit_context
> > *context, struct audit_tree *tree)
> >         list_for_each_entry_safe(rule, next, &tree->rules, rlist) {
> >                 entry =3D container_of(rule, struct audit_entry, rule);
> >
> > -               list_del_init(&rule->rlist);
> >                 if (rule->tree) {
> >                         /* not a half-baked one */
> >                         audit_tree_log_remove_rule(context, rule);
> > -                       if (entry->rule.exe)
> > -                               audit_remove_mark(entry->rule.exe);
> >                         rule->tree =3D NULL;
> >                         list_del_rcu(&entry->list);
> >                         list_del(&entry->rule.list);
> > -                       call_rcu(&entry->rcu, audit_free_rule_rcu);
> > +               } else {
> > +                       list_del_init(&rule->rlist);
> >                 }
> >         }
> > +
> > +       if (list_empty(&tree->rules))
> > +               return;
> > +
> > +       synchronize_rcu();
> > +
> > +       list_for_each_entry_safe(rule, next, &tree->rules, rlist) {
> > +               entry =3D container_of(rule, struct audit_entry, rule);
> > +
> > +               list_del_init(&rule->rlist);
> > +               if (entry->rule.exe)
> > +                       audit_remove_mark(entry->rule.exe);
> > +               call_rcu(&entry->rcu, audit_free_rule_rcu);
> > +       }
> >  }
> >
> >  /*
>
> Hello Ricardo,
>
> Many thanks for your nice and constructive answer.
>
> Indeed, sashiko's review makes sense and your suggested v2 is a good
> fix.
> I have replayed my reproducer to ensure that it indeeds fix the reported
> bug.
>
> However, I wonder whether the wait should still happen in the case where
> all removed rules have rule->exe =3D=3D NULL. Doesn't call_rcu() already
> free (kernel/auditfilter.c:96)?  If yes, could we skip synchronize_rcu()
> in
> that case? If this question is valid, how about this fix based on yours,
> which
> simply adds a bool to detect whether synchronize_rcu() should be called.
>
> If you think this addition is good, I can send a v2 with that.

It looks like a nice optimization, good catch! synchronize_rcu() is
usually expensive, so calling it only when necessary is an improvement
for sure.

One minor detail, I'd use 'entry->rule.exe' instead of 'rule->exe' in
the need_sync check just for consistency.

>
> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> index 1ed19b775912..e2cd27b17590 100644
> --- a/kernel/audit_tree.c
> +++ b/kernel/audit_tree.c
> @@ -545,22 +545,38 @@ static void kill_rules(struct audit_context
> *context, struct audit_tree *tree)
>   {
>          struct audit_krule *rule, *next;
>          struct audit_entry *entry;
> +       bool need_sync =3D false;
>
>          list_for_each_entry_safe(rule, next, &tree->rules, rlist) {
>                  entry =3D container_of(rule, struct audit_entry, rule);
>
> -               list_del_init(&rule->rlist);
>                  if (rule->tree) {
>                          /* not a half-baked one */
>                          audit_tree_log_remove_rule(context, rule);
> -                       if (entry->rule.exe)
> -                               audit_remove_mark(entry->rule.exe);
>                          rule->tree =3D NULL;
>                          list_del_rcu(&entry->list);
>                          list_del(&entry->rule.list);
> -                       call_rcu(&entry->rcu, audit_free_rule_rcu);
> +                       if (rule->exe)
> +                               need_sync =3D true;
> +               } else {
> +                       list_del_init(&rule->rlist);
>                  }
>          }
> +
> +       if (list_empty(&tree->rules))
> +               return;
> +
> +       if (need_sync)
> +               synchronize_rcu();
> +
> +       list_for_each_entry_safe(rule, next, &tree->rules, rlist) {
> +               entry =3D container_of(rule, struct audit_entry, rule);
> +
> +               list_del_init(&rule->rlist);
> +               if (entry->rule.exe)
> +                       audit_remove_mark(entry->rule.exe);
> +               call_rcu(&entry->rcu, audit_free_rule_rcu);
> +       }
>   }
>
>   /*
>
> Regards,
> J=C3=A9r=C3=A9my
>

--Ricardo

