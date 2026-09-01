Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14D8331A6E
	for <audit@vger.kernel.org>; Tue,  1 Sep 2026 21:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788298519; cv=none; b=EtRViIsp91c6Jn2RCWwBv/Q5PjHgR5dsLftQ3cskDx94Vl1Ldd86POexMdfDeI+DcTOFZA83mDaJ9I1ee+0v/I+c0xuaJYYqPUgx//wv/JbzwNnQuwE1rje6cGvULzcgNh4UyV1zxd+fir8AmYX2nhV9igs0WDCKW3Ua5O/HgzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788298519; c=relaxed/simple;
	bh=mf9p58cMBVYfVcWyFSmmlKsO3JLi/Qf2gNci71PGb/Q=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=cn9dxXrcuzYx1ZWWWEBYGEId09bO0zIZVjzsOmm5bxHXgTKYH5Lbfch6xK3+D7zPtf8ngT/Ui9446Um2aruu3GMHzjHs5fp8lawmSgsCcqGnzCDj4hmEaY+cCLls8DqQ359lDm36uwvJcHqOlbRSeKwOXzTyjSTTP7JOYy6m2Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aGexhyFK; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aGexhyFK"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-52d5bfa4bafso3087281cf.3
        for <audit@vger.kernel.org>; Tue, 01 Sep 2026 14:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788298516; x=1788903316; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d8P1T9k9Q5xaHviJua4Ft5GkjAABFjDN/bQJ+wSyg+M=;
        b=aGexhyFKgYHSASXCITREmV2dR2lRbRFa70mo/EeN2/uLg7RFlwTtV6aFA6UwRmVZEj
         xultuzQBlVlMsih8jFMB99uEyiRyz+aL5agGDkjsqJm86LFpOCGR/Ki6h/pv8u4YWfaj
         CbwRuNXDZVM+qjfgMuG2fNRGVkH97tEy7I+Y+544MV2Fhg5mMAFjW6mtvwQ9lV6Pv/Lb
         9dYiRjM0P9tSvGPrnd11oD7VoFLJOqvioT8BGZDHHljgrXBzWqs8FDDjJItx1UMYEGYM
         CJUCwhWI8CKe0DP9kb3smfepNpr3wKbJ5V4oY0V/sulKPPuTNLtu0/NS9vItAv9RZxQm
         U5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788298516; x=1788903316;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d8P1T9k9Q5xaHviJua4Ft5GkjAABFjDN/bQJ+wSyg+M=;
        b=gs6rHOSdDTAbRqmT7tLWhQOtC4Lm+B2FfV10ppNRL64kZRuNeFU/1MuKkEa4xNkhnX
         xYyYRP/WdLS57FbUso3SVk1MWgi47xl1JRKXrvle3LgNqiuJ70DO6bb8J9ARtPo1V58/
         CFA+cgqJUcOcZrKOEK/9V+PccGH3brjaHKT+fe/lYknfo/nlbHlVIyb1Xzo5KFJ0ZMRL
         HTceIPDL+f3e+O6pkpi9M1eGz047qYMI0n0h4rT3wIGDWXE57pHw3YpJGV3F6jDTMX73
         xfdkoFAKaj3n6Xd6foRj6KC3L3+WTR6rx7pgZX0f3Wb1KhfiXBfHjOPLCxadehIlfKaC
         TwlQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqu0WwMKtp9IfByEA4at/rfCYo1qYkU77qVB4xkm9mSWdsdN2qpU2OK9p9X78dJdkAB4i/ZpQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nU2QARG5y8ExrMWrhMlNGKoU5yh7FGpTQdnOdD4bQxzT/zpDu4
	NoQ/QR2BKB7EsHFEd9qXAkk6YlUyyZPj4uerkeg2/cYVF9cObkNS3rvUoerUghxKhA==
X-Gm-Gg: AR+sD10V5nWGZ5mgC+GAe/vV5FvwJeUNqVmAO6DRDzFQAagd87ghdshTT2eWIweYsk4
	ZaowE1SRBPRm4AQYZqq9Id9Pd2WKst/LvNhL+RI858ScezorbkZeNgjLRuLDpqpfg/zajR5YYdH
	qTOia55TmWd4gVtohsg1M2kJaxYUcrHOBS01ZU59wKqqv3ri5br08+qgfnIcQMXwvR/HLYXynj8
	cmrU//X4zcUiCCVrFJ2D6pa5maHNbEV8GFiYOEZO4t4jR8r4CVB2Pn4ev0kgKeAFFXxi1R0fYjB
	7iqkf4RFQBuspywIiLMfv7WhS/6KUO1SUHRA/284DL7KEFzV7nbgbPsVu3UZq7HXgxctPK4pi8E
	lHRp+oWP/Ognte/GQL56mlPxlIhinCad2n3Ab9569/AcZPS0ZMG/3HHFaBwdXv6kTkw539oMxca
	QWWqEEmuFjoAY5eEvv8r3ssnTRgrHwYXXQrACZ8ja0c2ojm9LbCVm7fK2U+0EHtrgI83rlu0nRh
	37Pt3Q+8Ig2F9soDGG59uRvNNsPzcSm7A==
X-Received: by 2002:a05:622a:5144:b0:52f:4cd:13f6 with SMTP id d75a77b69052e-52fb93d50dcmr493029701cf.12.1788298516423;
        Tue, 01 Sep 2026 14:35:16 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530331dc460sm5476011cf.18.2026.09.01.14.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:35:15 -0700 (PDT)
Date: Tue, 01 Sep 2026 17:35:14 -0400
Message-ID: <1e277c072e35ee68419976510ed4cc7d@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260901_1121/pstg-lib:20260901_1604/pstg-pwork:20260901_1121
From: Paul Moore <paul@paul-moore.com>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>, Shuah Khan <shuah@kernel.org>, Eric Paris <eparis@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Amy Griffis <amy.griffis@hp.com>
Cc: Stanislav Kinsburskii <skinsburskii@gmail.com>, Frank Hofmann <hofmann@deshaw.com>, Noah Orlando <orlandon@deshaw.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH 2/3] audit: Fix filter rule accounting after automatic  removal
References: <20260806-audit-v1-2-ddd0d94ff0b6@gmail.com>
In-Reply-To: <20260806-audit-v1-2-ddd0d94ff0b6@gmail.com>

On Aug  6, 2026 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> 
> The audit_n_rules and audit_signals counters are incremented when filter
> rules are installed and decremented by the explicit rule deletion path.
> Rules can also disappear when a watch or tree is removed, or when an LSM
> rule cannot be reconstructed, but those paths do not update the counters.
> 
> As a result, audit_n_rules can remain nonzero after the last applicable
> rule has gone away, causing subsequent syscalls to allocate non-dummy
> audit contexts unnecessarily. A stale audit_signals value similarly
> causes unnecessary signal auditing work.
> 
> This can be reproduced for an inode watch with:
> 
>   mkdir /tmp/audit-n-rules-bench
>   touch /tmp/audit-n-rules-bench/watched
>   auditctl -w /tmp/audit-n-rules-bench/watched -p r \
>            -k audit_n_rules_bench
>   rm /tmp/audit-n-rules-bench/watched
>   rmdir /tmp/audit-n-rules-bench
> 
> The rm updates the watch after its inode disappears, and the rmdir causes
> audit_remove_parent_watches() to remove the rule. For an audit tree, the
> kill_rules() path can be reproduced with:
> 
>   mkdir /tmp/audit-kill-rules
>   auditctl -a always,exit -F arch=b64 \
>            -F dir=/tmp/audit-kill-rules -F perm=r \
>            -k audit_kill_rules_test
>   rmdir /tmp/audit-kill-rules
> 
> In both cases, auditctl -l reports no rules after the directory is
> removed. Run the following before installing the rule and again after it
> has disappeared:
> 
>   audit_bench --iterations 10000000 --repetitions 10
> 
> For the inode watch, the same VM produced:
> 
>   no rules:
>     median=38 mean=39 stddev=4 (10%) range=38..53 ns/op
>   automatically removed, before this fix:
>     median=55 mean=56 stddev=3 (5%) range=55..65 ns/op
>   automatically removed, with this fix:
>     median=38 mean=39 stddev=4 (10%) range=38..52 ns/op
> 
> For the audit tree, it produced:
> 
>   no rules:
>     median=38 mean=39 stddev=4 (9%) range=38..52 ns/op
>   automatically removed, before this fix:
>     median=59 mean=60 stddev=2 (3%) range=59..67 ns/op
>   automatically removed, with this fix:
>     median=38 mean=39 stddev=4 (9%) range=38..52 ns/op
> 
> Reboot between the unpatched and patched tests because an already stale
> counter cannot be repaired by deleting rules which are no longer present.
> 
> Factor the existing counter updates into common rule insertion and removal
> helpers and call the removal helper from every automatic removal path. All
> of these updates remain serialized by audit_filter_mutex.
> 
> Fixes: 471a5c7c8391 ("[PATCH] introduce audit rules counter")
> Fixes: e54dc2431d74 ("[PATCH] audit signal recipients")
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> ---
>  kernel/audit.h       |  5 +++
>  kernel/audit_tree.c  |  1 +
>  kernel/audit_watch.c |  2 ++
>  kernel/auditfilter.c | 86 +++++++++++++++++++++++++---------------------------
>  4 files changed, 50 insertions(+), 44 deletions(-)

This looks good to me.  I'm going to merge this into audit/dev, but I'm
going to drop the "audit_bench" references from the commit description as
I don't think we want that tool in the kernel sources right now.

Thanks Stanislav, both for finding the bug and providing a clean, elegant
fix.

--
paul-moore.com
