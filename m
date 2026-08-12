Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8DC29D26E
	for <audit@vger.kernel.org>; Wed, 12 Aug 2026 20:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786567618; cv=none; b=LUcVK0ijJYihjuwElWFLrR2UvlwC3JR/qg8mRpZx+ksRBz57AqOOtUXX+v6xxfisqIqKuhg7jM+bY+DNV7C1ItjMBLJxJyk75ZvnunjU3/wSPfkRxpk1ZD/OVvg+VyAky9/YkMExjnmIpN9UCmD723h1/3LF7rroKYry/YUJYPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786567618; c=relaxed/simple;
	bh=4I/32K7J6mxO5dI6LSD3V4ov9JkZ/eYl//UrtEaxHF8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=rzPLPgaStoNsOIcQME0q1Ep2mxPMAxfHjpspj0544RFET7e/LcPDt5FpzwFwyZJIf0nHhdnkb0NZlCexG6MpUW+X8Ep9Z1iHSGSqc30/Mc5sQSdBW9OKGYwVvWCUH3S5bNCNjt/JbYmLqVr8DVmGDHOoEPnRpxMEe/rHyG5EJk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZzPDPIbA; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZzPDPIbA"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e6c4a867cso96198885a.0
        for <audit@vger.kernel.org>; Wed, 12 Aug 2026 13:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1786567615; x=1787172415; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TRATdCyioF/pQhvH8lNkn9inChCQPeW2cLYdQioNcfM=;
        b=ZzPDPIbA1Wmp7ip52/urB7EBnboCiYx09XVmLk1OpKYWRf1/q7ZwHhwt9DxPO5KXJH
         OTWxP9/1sqJ/tWiEUKfby8XjYFd03MAMZyw9LOROGlzhqTwmxmztXkIp/4nVHWd/SDH5
         W5CPyFdLLjL6VQRqk1I4LsVlFt96Ud3le7lXqC/ktQmcZ4MmfTHdPy2TemyJYq4/lg4a
         1Rquo1WcraWWGJRixaTsEj/V5n3ic1LXhrSyWUep4Py1RC/79+BDu3eg+vu78R2+BrNz
         ImE9Y2keX8e0NFVXb6dWf2jQ9W4su5X/wTW7KWxIrwi5b7Dzw//yOM+ozNDRYuKx/Vr2
         Pfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786567615; x=1787172415;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TRATdCyioF/pQhvH8lNkn9inChCQPeW2cLYdQioNcfM=;
        b=qCZ7He35Lfaf3HXUZJSxfLUEBDAmt7KwLiujoo5lfIBu8i7FAEJdNLR1ivwmWxltrp
         B1a1dlygTWcbrt0Vx82HG6yfB/Bfpib0n2EaK/Vz7yh6wM3xXDBLhCIFkiuP54NQ9Qod
         YTqpkqK9sssi0WxgCVCYeG0yfiPef7VFAng9xfUk36Urq7LAIIizDPkDPX7gkKZyIGZH
         BavXvLFeBqeJ2lRp48RNJEQwlgBcqXMDvxKMFiSCXyF3tPDzWSepMCe43QkR7lHGgWOA
         2tU4XD9MWalpt1F6OW7FEzisEVqzDNTc4LrfdyD960ShW33La+kANf5TQLbZn1sQzdAQ
         UyzA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3NpPeACg9Mb4zFjZe5B/cgJ6VzLJi0kxpqiqGPP41TWR5+TJ3Itjr+pMXGgwH+B2qEyk8xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcHbLJhP1Rv17Bq3VsYzE5Ez270m8E/oB/6NhzvYSvYmdgAQOi
	nkfOeuUB1/Pv4fEyIrTuGeKBSbXg0UvPEbJyrR84x+C3E8QR9+G0RubST7TDmZz4vw==
X-Gm-Gg: AR+sD12eAYcV323sl5Zr7XWTQQxKfmWqZzqJzsS7AOME/1vDDXiAyeC2SdY4pcInJUk
	/xHOD0oSQ40cTrbVgzOa5e7UE0zmPPo6JLXMjdAHVW7t7I2a1gX5btTMBfafhpm7OOrvW76+mCJ
	EOkwqsUtWEVZcpmf2+vue9h4qR8gOCf0PCq0QpKvqhdiSLprUtr5N1YKKuNk+dVYxTorSKrO0tG
	cy96v/zYpqtZMbKnjHmPKued6PbTQG8XbKXVr1iJ2lg/5fjjA/4dZ+aNd12+fuYUHuKt+jopGvV
	Jg6IqG7ev0odUlIU40asnYNdTiT/lByOCSfAJJovH38L3kzVDdE/kt3ldZRbFKTQWF7n8PxzoZ7
	pA0ORdk5DAsp4oXnQqcQHn9sciZUNcyTmRcAO+2PSMxwYvMGqpfQsxmZ+tp2S8I5lt51hnoEAox
	aOV5rwisrN95XmSll3cDP1G4ONpOLYa7FV1Kn1QVbJe5ua62531tJ/aDABa9wpWraCwxSyfwY+f
	a5kD/hoIbM9q9dUOFghP0EV7JccfzLY8w==
X-Received: by 2002:a05:620a:3901:b0:936:883f:e994 with SMTP id af79cd13be357-936bf9fe198mr93596185a.20.1786567615310;
        Wed, 12 Aug 2026 13:46:55 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936b5dd3f5fsm213705785a.8.2026.08.12.13.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:46:54 -0700 (PDT)
Date: Wed, 12 Aug 2026 16:46:53 -0400
Message-ID: <ab0a41e0c2a549f8d684706c02b671c1@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260812_1638/pstg-lib:20260812_1616/pstg-pwork:20260812_1638
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>, audit@vger.kernel.org
Cc: Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org, =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: Re: [PATCH] audit: avoid dropping live tree ref on fsnotify rule  autoremove
References: <20260811220128.275783-1-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20260811220128.275783-1-Jeremy.Jean@oss.cyber.gouv.fr>

On Aug 11, 2026 =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr> wrote:
> 
> audit_del_rule() is used for both netlink deletion templates and internal
> fsnotify autoremove.  The former passes a parsed template which owns a
> temporary tree reference; the latter passes the installed entry itself.
> 
> The unconditional audit_put_tree() at the end of audit_del_rule() assumes
> the template case.  For mixed AUDIT_DIR plus AUDIT_EXE rules, an fsnotify
> autoremove event therefore drops the installed rule's live tree reference.
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
> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
> Tested-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  kernel/auditfilter.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Thanks for finding this and submitting a fix!

This looks good to me too, so I'm going to merge this, but instead of the
normal audit/stable-7.2 branch, I'm going to merge this into the audit/dev
branch since we are likely only a few days away from a v7.2 release and I
think it would be good to get some additional testing.  I am going to tag
this commit with a stable tag so it will/should get backported once it
lands in Linus' tree.

--
paul-moore.com
