Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825930EF95
	for <audit@vger.kernel.org>; Tue, 14 Oct 2025 23:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483584; cv=none; b=Up/Wf+dzilpkpcUao/UQvaB1EZBCYrD0hezkAv39+wegY7y3xgqf3v/tyBtsaBZ/P5pwTx9I1rCKbV2jpa9se1HcwyIhdDgRyxsZa+LORJfuW91T+a/pME+b5j+4tpq9nDtjIoUXVhgEPkiX0ILOktoJ4tJEJlbNuJw5Mq+zl1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483584; c=relaxed/simple;
	bh=THERYyfWpJts86ukp6+/qN9qrzmQKu6JuEBRRXPCS04=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Bm0RZ+dLtYYJFy9I0m48q1EH9EeWZUy791qurWNMka9NKm3vyKzQIMWUXP1K9MFlC1pMlZwqF6qVasnfOlMztwrnjWVcKXHhQft6flHH8vslvAypAeN4Q9UOUOp0Q/f6GwEVIZhw1yQGNgM2tX+3b7/vtGQa/biKbcxXvZ2WUeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GkIkFMgv; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GkIkFMgv"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-87db3aa478fso637635085a.2
        for <audit@vger.kernel.org>; Tue, 14 Oct 2025 16:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483581; x=1761088381; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YlJ/rymt2z0wf/HxlvzM0A8sd5hIISBlOct/3Lv9hgc=;
        b=GkIkFMgvsbHSUec2iqXrzQ6YkQNWroORiwcfzim1k+yimK40eAgy/MJ7vsZhnVCart
         eEL43wryNNCskIbZG2i4xyXjsZpW7jE60WE9uuXlFDvar85+RJXi6oEsYueFgaNTO8Ww
         YQuHfv509GC/Femn5YIK/rH54kyHYPj1fMFpxdNPOIgvikS+sraeWxz3eBjg27wkbX3F
         H0QXkiU9qtI9b4LiMp/KB2yPA0ysZuX+EfDeNfkbPKyRQlOHrgHtxfj4YQ3OkcfZLP4L
         4BD8k2RHQlcwYPGeINzZBMHXGM3N4fctvX50MFCmXFK4ZAt22Mb2WV1d+D9LuA2TW3tk
         htEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483581; x=1761088381;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YlJ/rymt2z0wf/HxlvzM0A8sd5hIISBlOct/3Lv9hgc=;
        b=CcxySJtntVMtnwVopk+d3K2rXcCj7uq8VfBCYoyD31NKqJzYGfFlh20Ct40LvbU0tj
         ctz3H8bMSCCnBBMPtdrO8gSDjLMpl3ROmUT5tdvDYBCrzjX3j3D3sDXTV+/6efqWFRVv
         2PLZQv6Ea57bw9pDPpeNuFDB3FDUXdloSFgzYLN34wuXYN0kWIjUWKHFTfMwCwE6XDWU
         PuWhFg+iZi9xuHux6wtm8DbaLZw9yTIydPOdt+DTtY4wOqj04dPCDiOo+5YeCUNRA1hn
         sqV1DP7dEDIa7KQ54DvSGmKmRg9pF3l9fQGy2uR2nyMRkdvSHSPFX6qtu0FRLpplg2xE
         v4IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD1KlV1SoeCwTp0y7vXMvUCutOcNoJ/jniCbzXDTryLY6r2KubBo+ss0ZSjaiURddYgrQxlA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5kP8MjAtK2y33LhmpIorf4TX6MrCPX9w8D7Cc6khO2dxI2Afx
	aK8RZVhlAFGLjPPUsTb4CSAiY66nWszCGeyrxdb+VBSf1sUm+o+kI8tYdbo2JnQ1Xg==
X-Gm-Gg: ASbGncvxKnUh5tPDeCoKh0KBOe4/7F3BtFbaae4Yjl15u59vhfVj3yVb7RBZfN3PN8r
	LdTtwL+oQudZugABOANQGPZB/TgF2d1XvO738ifRpVEV2f0lSlYltwCLT8vOAZ8Vs2AdTOo6npL
	VJDxops9wna88le2g24JF9+Ne2WHXdKYhAsHeh5h+2EDHZZHKyBYEmC4I0bsbJqg3TjKq2LW4/4
	fBuyN66mu8VzzIn+zZAOo+W92sfLF7wkizsdsFGCtT1gdxugCg/Vy61RSlUFvkwg23VhKgT3EhB
	7IaxPk/I5SiLpe/fhHI9/DuUwodEgmEGksJ6A+Wcp49BSGw9zc58/lY1lbj/sWXduXXl9K+UP+E
	D/qCkPgR08byIaLOTwE1HUQ6P0UVR0LhMgAPR5cte3S2DLKvuZISkUJKMzxbhyGSaCefeuTXa7E
	K53qttq2MyZpY=
X-Google-Smtp-Source: AGHT+IHjfyLXfSHciAF/hfVvhvyE+ji/i+hx1L96OGYtoV5M7LCsXCFga6nnYCODgc+TQMAmXTHAGA==
X-Received: by 2002:a05:620a:4589:b0:84a:af34:5b7f with SMTP id af79cd13be357-88352d9a115mr3780054485a.75.1760483581287;
        Tue, 14 Oct 2025 16:13:01 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-884a293bcbasm1290971085a.58.2025.10.14.16.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:13:00 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:59 -0400
Message-ID: <8f72249ed9358a895e6821495cab933a@paul-moore.com>
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
Subject: Re: [PATCH RFC 12/15] LSM: Allow reservation of netlabel
References: <20250621171851.5869-13-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-13-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Allow LSMs to request exclusive access to the netlabel facility.
> Provide mechanism for LSMs to determine if they have access to
> netlabel. Update the current users of netlabel, SELinux and Smack,
> to use and respect the exclusive use of netlabel.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h           |  1 +
>  security/lsm_init.c                 |  6 +++++
>  security/selinux/hooks.c            |  7 +++---
>  security/selinux/include/netlabel.h |  5 ++++
>  security/selinux/netlabel.c         |  4 ++--
>  security/smack/smack.h              |  5 ++++
>  security/smack/smack_lsm.c          | 36 +++++++++++++++++++++--------
>  security/smack/smackfs.c            | 20 +++++++++++++++-
>  8 files changed, 69 insertions(+), 15 deletions(-)

We discussed this patch in a separate patchset, lore link below.

https://lore.kernel.org/linux-security-module/20251001215643.31465-1-casey@schaufler-ca.com/

--
paul-moore.com
