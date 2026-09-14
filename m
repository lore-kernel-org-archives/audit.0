Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237DA49F13B
	for <audit@vger.kernel.org>; Mon, 14 Sep 2026 20:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418518; cv=none; b=mv2/gXbW/zySRNQs2J1WxekmvcPDAd983FNvYKDIsiMbqwctTHHd04h7F9SukMAfiBTWqyYC3yZJ6+0v7TkT/2rNhq6I/zrp3ib29mHv5qRlvsqXvCi5fSBz1X25bZD+Kh/hVCLLqPj6VkVNcau74G2FMjEFcfdwaneb1UQFtEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418518; c=relaxed/simple;
	bh=NGWB4j6Qtj1I45qJXTxUF3DXiZ03+1wrOcaEWMEdRtc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=mxcp4ngSRMO34HH+US4HoL86EI93qsXQaey9iQNE+sxwhC/afzsUa23PDyJgJYWRyX8TJZd6Yo7f9fufUEsIiyQjTMMGlrhriwEa9oRLik6lUomAuGm63xAHkjuMrfHf5f6RDNVDEG3S7oLoInvr/vpgBsjg7muQcfh2uJY2QAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BKJZYJqx; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BKJZYJqx"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5303932c4f3so19978571cf.2
        for <audit@vger.kernel.org>; Mon, 14 Sep 2026 13:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789418512; x=1790023312; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=weFISBwya/NR8Sn9j+ZA3fbgOeUtW9dlmxru4a9CsTM=;
        b=BKJZYJqxLJgFemMBcjr5I/aDXNKPtJB3WRJtLpLBN90kCCOc2ISZa//Hx+A9+uy7hz
         KotROizMJXWX9tEzVf5O2jdHFH3zcLlGP6MzE7D9BcffRwl5dnFhOwNpSiEVpj1HEnJ7
         EvvPhvn7MfJE76qXhcCt4bZKswpUqfwd0aWhG8mfZX2zxmbfWiqBIzrihkzUvkRM4+pU
         0txeqCV4C+FMMdpJa03B+HismbOogUi7Ezhk+FqcN08IynGTUWXRYeAFxW76NBiVlJ0L
         L414LmF6/TYULPjGTgneeLNYrcAk3bxDHO3JN/fQrYxHr7NjczBjhvGl0Vfc2MBYNYf7
         gRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789418512; x=1790023312;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=weFISBwya/NR8Sn9j+ZA3fbgOeUtW9dlmxru4a9CsTM=;
        b=FBOxwzicSuFOiBUnVScaUBinC30SSUaEQu7STC2cLr/jj+0RBVvtQPnzAr/mcSyEQ8
         p0ryIWlNyIhfTzGxpxnMD1dfsXHIHWy2bOkSwdFFma3XEBX+GKQ2YNbMwMAqrdn1NMPb
         ft3ZMUt4wOekiMvkEE1CcczpFu69v23ugruqMlD4wlzcdNbNYJweRolJh2GhipXKg/Wl
         Hk9bBaMmnVI1xHYeXvSCRZRb9nq/IslZlPeIlxCh4aF4mAGIPxY2k7dEdSmZyFpLztsy
         kuSH4w1ajUHjchmhrAdJWOBcofgy8glp4GlLEGA7EhpJOX4AqAcQhqtyDNS1gg+PensX
         cDow==
X-Forwarded-Encrypted: i=1; AKwUvByel6nWN8KTazWmJQxBRTcprOgfJwrir3iZSRWJqTHvaU/5qJ0rAwuo4IGVcmwrbV4c98ytEQ==@vger.kernel.org
X-Gm-Message-State: AFuF++m9rx3dpNwpYFuw52heW2LDeFs2IjimO2z+Ha4stjPz7krSlg33
	nCZx/xHAi3voxFi17mvU2fCcTRXvRtiPX1dlpH5q6YQMeUDKMNPGRlYyam/3l0Wk5w==
X-Gm-Gg: AYBFou3KsN6KRlBt0DqHnAbPRPoWIZ03yWwQsKEyMhoupL3YZYT0e1TijYpb6+x3nTW
	3kcQudp3DSqsR6u2f5uiVaBI30EBWU8SluA1on1kyyWPqPzDNJtmLiRgbg02AonUuQHZ2QOtBxr
	plZtkwtApghmeIUAhfALhS4vFKXWAACg0s89+oN9tUpyVurx538Ac94XpYRGfmJqaUBTMyvYN0B
	Z/b2pnHBG3YByc7HHrDc7TNfZjw0fYS905BsY9nAllLukVXFA/uOpdJ0tfIIGfXDw4j5afDcBOQ
	9FX0lWeUvCwjseWyrQGXYRgu2WjfhdinD6yBNaWt67RtHxHFJVAS7t8uV59Bvri+gGAlnC6LOxX
	RLxr73sjB9//0b2p8JgCvOQwLWyfkA8Kbjybxb2PrwL+SJMnunQcpCGcUUVvAbmXNRG3P48krR9
	ASroZRCk9oZ1y4TG3FU5rlu7GZnn2bPAm8r7uzXg7CCkB8n00rEiZoyYVvD9BWyA5QVo3NzuKTT
	GO/BtTzSZ9ry39U+lI1f2uXpE4lzwB++nnogSz/mjv9Ja/McBK6iE5jgZGuof3x7ZW+C75DdtPR
X-Received: by 2002:a05:622a:15d6:b0:530:b2e1:8e38 with SMTP id d75a77b69052e-5310d063e03mr64295201cf.51.1789418511760;
        Mon, 14 Sep 2026 13:41:51 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca3098easm108403901cf.3.2026.09.14.13.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 13:41:51 -0700 (PDT)
Date: Mon, 14 Sep 2026 16:41:50 -0400
Message-ID: <af4448a7a2b428d0f4af0ea4c19abeff@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260914_1619/pstg-lib:20260914_1251/pstg-pwork:20260914_1619
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Ondrej Mosnacek <omosnace@redhat.com>, "Serge E . Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, audit@vger.kernel.org, kernel-team@cloudflare.com, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] lsm: Preserve full ioctl commands in audit records
References: <20260910144837.381855-2-mic@digikod.net>
In-Reply-To: <20260910144837.381855-2-mic@digikod.net>

On Sep 10, 2026 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> Ioctl commands are unsigned int values, with their encoded direction and
> size in the upper 16 bits.  However, struct lsm_ioctlop_audit keeps only
> a u16, and the common audit formatter uses %hx.  This logs 0xc00ffeee as
> 0xfeee and makes distinct commands with matching low 16 bits
> indistinguishable.
> 
> Change cmd to unsigned int and use %x.  Pass the full command through
> ioctl_has_perm() as well.  Its driver and xperm values remain u8 values
> derived from the same low 16 bits, so SELinux enforcement does not
> change.  Commands that fit in 16 bits keep the same audit text.
> 
> Cc: Jeff Vander Stoep <jeffv@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: stable@vger.kernel.org
> Fixes: 671a2781ff01 ("security: add ioctl specific auditing to lsm_audit")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  include/linux/lsm_audit.h | 2 +-
>  security/lsm_audit.c      | 2 +-
>  security/selinux/hooks.c  | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)

This looks good, thanks Mickaël.

However, I am going to drop the stable tag and merge this via lsm/dev
instead of lsm/stable-7.3 simply because we're changing the audit field
(going from a 16-bit to 32-bit hex string) and I don't want that to catch
anyone by surprise in a stable kernel release.  I will leave the 'Fixes:'
tag for reference in case there is a downstream that wants to pick this
up as a fix.

--
paul-moore.com
