Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B6F477E28
	for <audit@vger.kernel.org>; Wed, 12 Aug 2026 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550395; cv=none; b=sD/Gw6fLioweu8p5+hhSmsdz4QWf2M6FnWIcP1Q0yrUgmzp95GQtUCSsECGzirnxlMUjCba4/JLYi8XdI/nJFyAtXFbGUpI2J6pNTW4VQekrZKHoxcnq9bN3JhGGY9KcwCVoCbKnkAwh9QbnyphNiGtLnXpVTBpSt96ivtspLYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550395; c=relaxed/simple;
	bh=lNri8v2Q/r9NFRrfLadJhdmPEGChFfJBd9vL3iVMKuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8q6vI/P6ujT0i1h6VDCDB4BWiB83NuTaKmIycAI6WLwlbXj4mvPFcZjqcxHYR8jN2GpvJfCPkuugQq5jfAdTxQ7QZ3Lc1TJqWJa5Ikn+sCbHlBW24AUMlvWp+pqZ7p10+AIO6bFl+vvXW1x9V6Riir69xlXcx7bkX+cLimGDf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DEbFXgQp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEbFXgQp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786550392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0scKLPOx43FEdah6Lw0ZsI57S7nTRPvyJpBjUipLS3U=;
	b=DEbFXgQpumAFRtGpCavFJjxehw3v/3gC9M4Jns0BeKl7diR6BFUl7pZGv3t+IU3nRoq5Wl
	MeGKvLT7Tl/duzx8uGdi10yRwMNQLbOFXEz+3r44fJw+V/+qup4ytI4NpFq4wPkL5DVFvK
	N11lXBcrnm9EODJs2VZ22D0Tnxst6CY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-iZtf4i_-MQmXXzjrBbh7Qw-1; Wed, 12 Aug 2026 11:59:48 -0400
X-MC-Unique: iZtf4i_-MQmXXzjrBbh7Qw-1
X-Mimecast-MFC-AGG-ID: iZtf4i_-MQmXXzjrBbh7Qw_1786550387
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c15e82278cbso63295866b.2
        for <audit@vger.kernel.org>; Wed, 12 Aug 2026 08:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786550387; x=1787155187;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0scKLPOx43FEdah6Lw0ZsI57S7nTRPvyJpBjUipLS3U=;
        b=hKmZZqL/PTHOgW/lBzH0EeTvYwJXZAh0NUMB/e+p8qxvPHEzeJXaCJacRleIcQKBVB
         Jzg3wXWigeqy9NIw+G8mmN1awy5Lymu5L1fnWF5mKzWI/rXG2rOqGrhapJ83VO4j3SaA
         uM7oCg0TLMYkK05rTi6Hld5GrSJ7Z1M+gomkwv5XqerwzreScc52Gq3X3+oVR9Om+Yja
         lNbj2GuVDsHl3oAGxcorcLRWxP0qcXLqaObKG0Nt5li1inbOOJCxNgKf2vk9xIwud/02
         9zlkvF2jwlV1Q1DAk8cant/5xJPyYJUUGApMGABAeVH4s4lxXrdKFjjAIT3OkqiB8hiu
         wEQA==
X-Gm-Message-State: AOJu0YwmRDaMCgH5XHRpqNuRw0t1F5QNPbcrOt8nDkN68UditnmaGWDy
	Tl7VMerRIeSX3Ce2dI5425u9nkTIpQGnfkOu4xF7yGdHpWJZHwUigD0ZQ/5FYVqTogpJ9+x4vXz
	QFtsPx1/G/6opuDBvidDQd5lUyLE9eTctasa3jgVVenx7DrRrzuidjoLHwyPdyNtw9o8i0JjYA+
	4/tZ0hsycSObSct/6GKHDrW8gPcJQUSeLEkBiDrR0tSMXK
X-Gm-Gg: AR+sD11KsWG4a8BSrPB2FME/Li2b6GXH/8eC6T2P8RuyHQgAiBHzaBHGHuLk6NUyKiu
	pMgDul7pwXAditKN4Hy4rp9+hebwsAzoJUNlMhpzdtNaoxP3c0OADaERaObtNXKZ9Odg9S3Y18A
	MZNkxab/Ro6lEfN1iY0vwBf11yr10ChG+OSPbUI/IJOXK4wbx3CH1aiCwZ6J6LrWT2cp9OJZPDB
	CuexABm226BbopouTL9MHnMafLGhla770HkoqZ0ZrzE8z1vP+dmKk2n7ss3F+pXaeJz99nQuNpj
	MCg=
X-Received: by 2002:a17:906:4789:b0:c16:29eb:e834 with SMTP id a640c23a62f3a-c20f2fbdd0dmr285256866b.21.1786550387486;
        Wed, 12 Aug 2026 08:59:47 -0700 (PDT)
X-Received: by 2002:a17:906:4789:b0:c16:29eb:e834 with SMTP id
 a640c23a62f3a-c20f2fbdd0dmr285254666b.21.1786550387090; Wed, 12 Aug 2026
 08:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811220128.275783-1-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20260811220128.275783-1-Jeremy.Jean@oss.cyber.gouv.fr>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 12 Aug 2026 12:59:35 -0300
X-Gm-Features: AUfX_myQl1VUN_7eobNn_0Oc2n3JWLbgYrvtnvEq8ohTwSkOSUz8SmQYlmItKqs
Message-ID: <CAABTaaCM=y76EswxmG-U6LowPmWpZJSwdpFMPkMuOtzGYW8t-g@mail.gmail.com>
Subject: Re: [PATCH] audit: avoid dropping live tree ref on fsnotify rule autoremove
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: audit@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Mcn6P_AGIfV-psRJl7B8fmvUnXiR_x7v5qcbnGv1GuI_1786550387
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 7:02=E2=80=AFPM J=C3=A9r=C3=A9my Jean
<Jeremy.Jean@oss.cyber.gouv.fr> wrote:
>
> audit_del_rule() is used for both netlink deletion templates and internal
> fsnotify autoremove.  The former passes a parsed template which owns a
> temporary tree reference; the latter passes the installed entry itself.
>
> The unconditional audit_put_tree() at the end of audit_del_rule() assumes
> the template case.  For mixed AUDIT_DIR plus AUDIT_EXE rules, an fsnotify
> autoremove event therefore drops the installed rule's live tree reference=
.
> Repeating this across rules sharing the same tree can free the tree while
> another rule still references it, and a later autoremove dereferences the
> freed pathname while comparing rules.
>
> Move the temporary-tree put to audit_rule_change(), the caller that owns
> deletion templates.  Keep it in the AUDIT_DEL_RULE cleanup so both
> successful deletion and -ENOENT still release the parser-owned tree.
>
> Fixes: 34d99af52ad4 ("audit: implement audit by executable")
> Assisted-by: Codex:gpt-5
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>  kernel/auditfilter.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 7f791afe5791..666c2091b9e4 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1023,7 +1023,6 @@ static inline int audit_add_rule(struct audit_entry=
 *entry)
>  int audit_del_rule(struct audit_entry *entry)
>  {
>         struct audit_entry  *e;
> -       struct audit_tree *tree =3D entry->rule.tree;
>         struct list_head *list;
>         int ret =3D 0;
>  #ifdef CONFIG_AUDITSYSCALL
> @@ -1071,9 +1070,6 @@ int audit_del_rule(struct audit_entry *entry)
>  out:
>         mutex_unlock(&audit_filter_mutex);
>
> -       if (tree)
> -               audit_put_tree(tree);   /* that's the temporary one */
> -
>         return ret;
>  }
>
> @@ -1158,6 +1154,8 @@ int audit_rule_change(int type, int seq, void *data=
, size_t datasz)
>         }
>
>         if (err || type =3D=3D AUDIT_DEL_RULE) {
> +               if (type =3D=3D AUDIT_DEL_RULE && entry->rule.tree)
> +                       audit_put_tree(entry->rule.tree); /* that's the t=
emplate one */
>                 if (entry->rule.exe)
>                         audit_remove_mark(entry->rule.exe);
>                 audit_free_rule(entry);
> --
> 2.47.3
>
>

Looks good to me. It passes the audit testsuite as well.

# make test
amcast_joinpart/test ................. ok
backlog_wait_time_actual_reset/test .. ok
bpf/test ............................. ok
coredump/test ........................ ok
exec_execve/test ..................... ok
exec_name/test ....................... ok
fanotify/test ........................ ok
field_compare/test ................... ok
file_create/test ..................... ok
file_delete/test ..................... ok
file_permission/test ................. ok
file_rename/test ..................... ok
filter_device/test ................... ok
filter_exclude/test .................. ok
filter_exit/test ..................... ok
filter_inode/test .................... ok
filter_saddr_fam/test ................ ok
filter_sessionid/test ................ ok
io_uring/test ........................ ok
login_tty/test ....................... ok
lost_reset/test ...................... ok
netfilter_pkt/test ................... ok
signal/test .......................... ok
syscalls_file/test ................... ok
syscall_module/test .................. ok
syscall_socketcall/test .............. ok
time_change/test ..................... ok
user_msg/test ........................ ok
All tests successful.
Files=3D28, Tests=3D303, 107 wallclock secs ( 0.10 usr  0.02 sys + 31.68
cusr  1.89 csys =3D 33.69 CPU)
Result: PASS

Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
Tested-by: Ricardo Robaina <rrobaina@redhat.com>

-Ricardo

