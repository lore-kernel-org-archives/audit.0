Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198284F390F
	for <audit@vger.kernel.org>; Wed, 23 Sep 2026 11:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790164548; cv=none; b=jYNUfkffUyESIGj8yzQ9Fqq4fC9I0yeoyZE/oKoBMSDXPILGzsTHJOg5nV9e3/r+q+qBBvhfEhZm3UxtZgA5AZqN7xc1RbjyHIeZFtgNmdqetYqkE1p6hB89gApHjNYEDTsqUZQ3VIeBwF0SRBs6mPFm/tZEmkLhZNqryNdPU9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790164548; c=relaxed/simple;
	bh=VZdhg/2WWxj23TMQOLxv2EYnD9sVykx5dWuo8oKJNGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IOEviBrzrgsZ0yQs8i9YRiWbpUE771TFUrVlO1a7nXaCTQtmmj+YTu0ujjV4IZd3dMMI3KpZ6rUExF1FC0Efw7MXYscYOm0f1OLf8QlP0tFm5q1YDdcPYmhcosDfuNH6qhXHVeEekoZR9Xxk81YYd1J+BuDbp04Kjz1g50Ieops=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dPJXw+GN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPJXw+GN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790164526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfFWfiDFRsRocPK6MajUZe1PhNrKZn5zM8GQiGakpDQ=;
	b=dPJXw+GNaO0dRiRaG7sq1P0qAC5lGJ/Lt9+9aLUgT1UnD7G5rBrVw/Kh5lGF6TH3Oyr67p
	l35UL37RfRCiZ7eE00jftcNUwbAFJ4queqFqIxBe70WttlQ1Uqad6txMhPTvo3I1t6xCwJ
	OXcxc59IdGLbrtDtBfaIPQEZaW0wTXA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-lwB5BeZBOZGKCUyVp_exAg-1; Wed, 23 Sep 2026 07:55:24 -0400
X-MC-Unique: lwB5BeZBOZGKCUyVp_exAg-1
X-Mimecast-MFC-AGG-ID: lwB5BeZBOZGKCUyVp_exAg_1790164524
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c2945f5e851so62711466b.1
        for <audit@vger.kernel.org>; Wed, 23 Sep 2026 04:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790164523; x=1790769323;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wfFWfiDFRsRocPK6MajUZe1PhNrKZn5zM8GQiGakpDQ=;
        b=RVHzGg4SXS3m17Gypqungf2mh3fWvHdaHrOzgdLFUzUsnRwHd1q5DXeJP0cjHMTHBY
         wkaEQ42kE6x1HGTf1oX81ab7fNe0JH4gTwwnuRW2mG/BRV8y4gb4zOGCQnj+Pet/sKQy
         BFWJFiHXW45+/DQPgrxG3CCaRsIV8nPsd4xwMvUFkCaKsnvxw7GErpic06eYj6CFU80E
         FM/frt74Qsz24PAw2juzki3uBRiJmBQF2xKh7F3XUgP30FiTQIF8Iqx2LRq5EURcvp1F
         OhpwaIzrjHRQycfngKjn7BCd8khwCAmokk5A78lV6nluZXmzgqLiecdWorXzTsu+0pxy
         sONQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQSG6+HadJwER46K6yFRDzOs2doVswIzP9NA6sQmYiDt1vzspQQ95jyKKrWNiTxIRqHMivZA==@vger.kernel.org
X-Gm-Message-State: AFuF++k2bEJ7H8a8XGSLTUSDiEtSSTbpUA+AMkkDCf1x63gdf+q6r5HQ
	vlSGrMntqMvLseQQTFodBSy6I0M734UNSqhvHEptQayD4KR5oyS5slCmdbExC1j0mRmLv5ee1td
	tM8Qxi1qhxm9trSHP5brmTi59oMks5wnvls/6UMSvh2qw3Sz/GbAEL6J/rtC3pr9OYa3Cc8QKbe
	hVjPkOae7k62sJuIMDaWaq7hy9SHTnRX0=
X-Gm-Gg: AYBFou3pZd57G88pvfmQNrttSM96moPZamNFdZ1LW7/pjKd5k8GwuatwbRN7RXPO2TL
	/e4GvCoIepeR04T60QLmnMSPtgHhdwYvuyuR02yAUloapDu4IOYwCfajbM6zYgacsBuuE2sTWr2
	AwQ+hP5M9jUwf0YOgttO7YNovnPZgDvUO9gUogJGafq4FG8kM937QR8vrKImMpapk/SRCId68VL
	36+hPKxWW+m2p1/tabo+Ar1mRs+3HS2Z5OZZPtezL0n0dw24BNiXVsDhe3n5hQDbTFnd3DHFkvO
	tjk=
X-Received: by 2002:a17:907:6d28:b0:c28:fb3f:fe20 with SMTP id a640c23a62f3a-c2aadf9f210mr198480666b.30.1790164523630;
        Wed, 23 Sep 2026 04:55:23 -0700 (PDT)
X-Received: by 2002:a17:907:6d28:b0:c28:fb3f:fe20 with SMTP id
 a640c23a62f3a-c2aadf9f210mr198478466b.30.1790164523216; Wed, 23 Sep 2026
 04:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922202734.1344770-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20260922202734.1344770-2-Jeremy.Jean@oss.cyber.gouv.fr>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 23 Sep 2026 08:55:12 -0300
X-Gm-Features: AclHuK-nUTKQQ2wWEAK3vYcbaNjq3pmLpdcICbfm-hJLNCAdjoG-ETE2fFTin9k
Message-ID: <CAABTaaD_DA+=ywGNnZzJeXnwonh_=Abq8dThprJFQpM7Lc6eGg@mail.gmail.com>
Subject: Re: [PATCH v2] audit: fix exe mark UAF in kill_rules()
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, brads@mainlining.org, 
	audit@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zKE-zZV8Fh9b_LmIsk3hVc0bX7JtvUPkWo9DV3qzcyM_1790164524
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 5:34=E2=80=AFPM J=C3=A9r=C3=A9my Jean
<Jeremy.Jean@oss.cyber.gouv.fr> wrote:
>
> kill_rules() removes mixed AUDIT_DIR and AUDIT_EXE rules when an audit
> tree is pruned. It drops entry->rule.exe before removing the rule from
> the RCU-visible filter lists.
>
> After a rule has been installed with AUDIT_ADD_RULE, which requires
> CAP_AUDIT_CONTROL, removing the watched directory can race with another
> task that is still evaluating the rule. In that case, fsnotify can free
> the executable mark before the reader reaches audit_mark_compare(),
> causing a use-after-free.
>
> KASAN reports:
>
>     BUG: KASAN: slab-use-after-free in audit_mark_compare+0x8d/0xa0
>
> Unlink the published rules from the RCU-visible lists and retain them
> on tree->rules for cleanup. If any rule has an executable mark, wait for
> a single RCU grace period before removing the marks and scheduling the
> entries for freeing. Otherwise, call_rcu() already provides the required
> deferred freeing without a synchronous wait.
>
> Fixes: 34d99af52ad4 ("audit: implement audit by executable")
> Assisted-by: Codex:gpt-5
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

Looks good to me. I've checked that audit-testsuite passes cleanly.

Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
Tested-by: Ricardo Robaina <rrobaina@redhat.com>

# uname -r
7.3.0-rc4+

# make test
make -C tests test
Running as   user    root
        with context unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
        on   system  Fedora

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
Files=3D28, Tests=3D303, 69 wallclock secs ( 0.08 usr  0.03 sys + 36.64
cusr  1.87 csys =3D 38.62 CPU)
Result: PASS


> ---
>
> v2: Address Sashiko's review with Ricardo Robaina's improved patch:
> - Batch executable-mark teardown behind one synchronize_rcu() after
>   unlinking all rules, instead of waiting once per rule under the audit
>   mutexes.
> - Skip the synchronous wait when none of the removed rules has an
>   executable mark.
>
> v1: https://lore.kernel.org/all/20260921195921.4174830-2-Jeremy.Jean@oss.=
cyber.gouv.fr/
>
>  kernel/audit_tree.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> index 1ed19b775912..f2e81be8265e 100644
> --- a/kernel/audit_tree.c
> +++ b/kernel/audit_tree.c
> @@ -545,22 +545,38 @@ static void kill_rules(struct audit_context *contex=
t, struct audit_tree *tree)
>  {
>         struct audit_krule *rule, *next;
>         struct audit_entry *entry;
> +       bool need_sync =3D false;
>
>         list_for_each_entry_safe(rule, next, &tree->rules, rlist) {
>                 entry =3D container_of(rule, struct audit_entry, rule);
>
> -               list_del_init(&rule->rlist);
>                 if (rule->tree) {
>                         /* not a half-baked one */
>                         audit_tree_log_remove_rule(context, rule);
> -                       if (entry->rule.exe)
> -                               audit_remove_mark(entry->rule.exe);
>                         rule->tree =3D NULL;
>                         list_del_rcu(&entry->list);
>                         list_del(&entry->rule.list);
> -                       call_rcu(&entry->rcu, audit_free_rule_rcu);
> +                       if (entry->rule.exe)
> +                               need_sync =3D true;
> +               } else {
> +                       list_del_init(&rule->rlist);
>                 }
>         }
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
>  }
>
>  /*
>

--Ricardo

