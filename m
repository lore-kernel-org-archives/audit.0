Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8789C2E7F0E
	for <audit@vger.kernel.org>; Tue, 14 Oct 2025 23:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483567; cv=none; b=WlMS0ZTWVnxB/C2xCGqMC8ukBhVWq27qBKGfDOzWmGt30CRf7ouivJmedRU0CHm/+U3xodUZRnVmAEN4I0evsCFT7eAEalCNKGlO3stc9kUdU50E9OHfE58D70odVPX2Fl6zJMR7JRDcPE0+ntElO+1/io/6rhoRK8aAPZnUIRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483567; c=relaxed/simple;
	bh=b+JPuRya1KU5RJhAmgP2fLr3omiwqFKbt15uSqlXlxk=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=QLpP8KwaLlNC4dC4E7xRSBhXHKDY1zX+WE9LAuwWQLtp5WpVDWuH8Sqo7kR/2zFG30l29qc8VhLOh/zxUU8C9eVbwEShMx5bZ4tNngvydpfDD9+vGWi1IIq4FADcQnyVL7puRflOPGQxm7JZrEmp6IDJ5NdEPQVgAsI8saAK/20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VUQSwCfy; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VUQSwCfy"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-78f75b0a058so76303756d6.0
        for <audit@vger.kernel.org>; Tue, 14 Oct 2025 16:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483564; x=1761088364; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vVvdaze35/CRosAlcMdQpNGdw9QE4ISqfe//0KuZp3M=;
        b=VUQSwCfyYwnlAEqFXlFsAD3pTFNEVKVixzJ2/dcKjQU2RqclsciV8Vv14OZdy4K+9d
         p0Qbf4kAkpsXOO7UcKArvzpcCVW5RU6INa5eZbcTLXkAjyCsbHmQU4f1H4Tb/knhtC/o
         oozvtewSSWLEPo6vjsRoU45m7/J4O4wp2ojhDZSsATKmw0H5YXeUHSvocJry0LHU7OtG
         UdW24ZrvwOLT9t3xIRRd6fgUsYoYDO5C4xIT89Ior0+JLtIBL/jInQByYhux6Adj0Rx6
         NRNRHgkUyIIrliJ4zWvtSoJJWEkUYzkcboUdGnwXn/w8hYMYByR0daragyZPrHkZr2rs
         uFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483564; x=1761088364;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vVvdaze35/CRosAlcMdQpNGdw9QE4ISqfe//0KuZp3M=;
        b=UFjdv6qc9vp9DVlDWqdjAAj8zEkpjL5x/RXpskoA8sAX2eeRr5A7L/p9sKqAMrHIw4
         fii24enEELanx7btb2bxyX5TDmL0cllBBz9Yhh3/NxSZy3pyrjHrC/9NNYFFLtwQ7M0h
         cTDvWkpG7+7qshbQUxrMQwBMYm/BkMqog6D2ii3e7Ci/d+cTeRpQ/64eSolDfdnDuUZ0
         3TcEMURT2iJCsY4m8/0Jfm6DXFTHB38vCtEHPOvGowOEAzVm6ynBqT5K+EVpmAZcGyQE
         Cf2UgiuKlQQJepVy1ad9I70OlaS2YeJwgKFQpEyVngtgZIvSUWPRoYjP08f/rIu11IUu
         R1Hg==
X-Forwarded-Encrypted: i=1; AJvYcCW5WYuiJYnj3hFNmserW7LRJFRpAQvFNSO0Pdr2CaFfC2Z98gPORWFNLPvfYR1/7JT+o72puQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzSrIMazR1VRxt3s/PtCXSNpReFH47vUSpzIGQKVnfcHeA/EgD
	xJRhIPtxGA3/pEDqMgB+1eDcOx631LI9dtEqcgXdTgxstszkEcTeqECSWPutZhtIJA==
X-Gm-Gg: ASbGncsz3zlPy+V/HVtOPD2eVGw9qWlFhsIuMuRJG/WUAVooEnHBUgrNWEoIlGFxwYY
	MAaRYk6G9krbRfa939nVJdamNJNAciJE+dzo7kaYwSl3rQGRFCYb2j04K/vOtsb5DIIeRdaNAR9
	HUlfQRt8lN5jWu9m2oSIuf3Ylg5tOAfmhMUDGMY7LPTvhr0qFT/dvluERjiCSJSOhK6x/FRPKES
	J6L6AHlFnD+EZogIhnJhTwKscEtBEXpBDS8O32yoo1agu1z+4KYdsGGoW57OR8gCNUQcgE/JirV
	ddAHdx2pB4X+3lTmaARg2OmT+Ui4OZ8kH2nS7YGHt3JNSoLyuPNDaMvDbpdJOdXpzRJCS+XlwDi
	ABpfUH6YanNp8AlFgFj6GVKo1YJxscVHmaZnNKdiAJJa8Yd23mF/vufEdGG6e4hxT9bSATToiMp
	0RZs0rXrZGxIY=
X-Google-Smtp-Source: AGHT+IHIaLztJ0EzDzTfr0vpC8k7Pus9jJGW+Vxhl33MfL6VS+zErfGM1vlpYkIvsD1bC3Dy3OU/pg==
X-Received: by 2002:ac8:7f89:0:b0:4e0:b72b:7f6d with SMTP id d75a77b69052e-4e6eacf4870mr384481971cf.29.1760483564238;
        Tue, 14 Oct 2025 16:12:44 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4e881c8cecfsm7843551cf.19.2025.10.14.16.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:43 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:42 -0400
Message-ID: <cee3f6f2d0657e53f5313225fe182a1b@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251014_1821/pstg-lib:20251014_1132/pstg-pwork:20251014_1821
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH RFC 3/15] Audit: Add record for multiple task security  contexts
References: <20250621171851.5869-4-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-4-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the single skb pointer in an audit_buffer with a list of
> skb pointers. Add the audit_stamp information to the audit_buffer as
> there's no guarantee that there will be an audit_context containing
> the stamp associated with the event. At audit_log_end() time create
> auxiliary records as have been added to the list. Functions are
> created to manage the skb list in the audit_buffer.
> 
> Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
> An example of the MAC_TASK_CONTEXTS record is:
> 
>     type=MAC_TASK_CONTEXTS
>     msg=audit(1600880931.832:113)
>     subj_apparmor=unconfined
>     subj_smack=_
> 
> When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record the
> "subj=" field in other records in the event will be "subj=?".
> An AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based on a
> subject security context.
> 
> Refactor audit_log_task_context(), creating a new audit_log_subj_ctx().
> This is used in netlabel auditing to provide multiple subject security
> contexts as necessary.
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h        |  16 +++
>  include/uapi/linux/audit.h   |   1 +
>  kernel/audit.c               | 207 +++++++++++++++++++++++++++++------
>  net/netlabel/netlabel_user.c |   9 +-
>  security/apparmor/lsm.c      |   3 +
>  security/lsm.h               |   4 -
>  security/lsm_init.c          |   5 -
>  security/security.c          |   3 -
>  security/selinux/hooks.c     |   3 +
>  security/smack/smack_lsm.c   |   3 +
>  10 files changed, 202 insertions(+), 52 deletions(-)

Similar to patch 1/15, dropped due to this already being in Linus'
tree.

--
paul-moore.com
