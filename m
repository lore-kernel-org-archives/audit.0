Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CDC4A0912
	for <audit@vger.kernel.org>; Mon, 14 Sep 2026 20:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418520; cv=none; b=Ovyo1bttBD5NzOGXwi3Xq+aFB3z7iTM2bPA07mZX28gDi2tBfc7M2X4LLSx2a/EKA4g2ols1mCh2xPfWCgHy2AIc+aTyfXFqMUeX7mE/qRgkundibH3o6BqKVpPL4USaKArKBYVPQFs8DxCl64JnA1ul+jWKpASEc8mphwVyhTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418520; c=relaxed/simple;
	bh=7lTv3k07zA7RFFF2IudlduRWQ6nXWPTkRfXfmwqrpmg=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=OqQGxh2AzPP9rDKspb9F+OXwR6jRn8C6EQ0XYs1qxVoQJBtN0SIonChv3EvPmZlLNt3919W3jN/u3Hio+21aW6qxmQpoCQJyYgGWyvzoYNqqqFN5CoXg4XIk1f2frEWGLF9cwWt2dzIw7VuV6kQO2LXNQZx+VxORxE9yMzfuY7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LJ0gd2Mk; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LJ0gd2Mk"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-90e9e042ee1so43629236d6.1
        for <audit@vger.kernel.org>; Mon, 14 Sep 2026 13:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789418518; x=1790023318; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=duuPvdB4qaHPpjjbBizZlT/PQ2qkQWx6bSPOOeU9NRQ=;
        b=LJ0gd2Mk4rVAhY7LhAj4LxdK/Q2UvRbPY/ykcSWYDW9bvUIcOB8J1Tfk8oolBzJg7W
         Bbm6GU8iNYVyVq5A89lf8M1ucTZkhPcPor23j+3zyNcIsvvjxZYBjZy6OJQ2bpX32Pk8
         O2XwOQ37VvnZIBcA96MJ+oXA2/jm/yJ2ttirZsbYpTpet/yL+ITfi8DDcKIryn/jPTHY
         nHkSdQzwO8aCuuaCbH64Kwq+ormHX8imPIR5l5VzH9/1XD68WjNokIHTjx7srU6cOZrc
         /D+GZmwV1T0PVNoNSojoMDt/Me+KzXl/co041jTaaa+8IotiAs6CPSzYRFuVOEODh/Z7
         4syA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789418518; x=1790023318;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=duuPvdB4qaHPpjjbBizZlT/PQ2qkQWx6bSPOOeU9NRQ=;
        b=d6HWoYy3LtWMyhtY1S5Y5aX75HcJORR9jGJCuOXyQ7CcxduT7rEw9SbSZJjucJ09p6
         C9rQSefzi7rkkOi3BjywhZRj2+nrKzpIpjrAeV63isvAs9/v5Gsq2toLUh2oKDD7AYt+
         mV65J2VE2I+EdEZfz7rzn0GJcv4CD/bv/m6XR6gkahd/5vTNPaGu5yukNIQOj8mf3jET
         Ow0zZNPJJAiZ+27MOfguw5h1ZgrOZiPmP6WV3nLyhketwGVxjL9MTzqxc1kCc5353lj6
         yrMHcG8faAcq2+/kFI5c88wgrbflpDR+L2u5FcxOdgAxqONj0pblBGY1jCL4yzqE+HvY
         ZTtQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4AQ2/wIVVC35eJSs2IVPclf0na82qSiuUFI9NaUK8tgjv3wb7+5PPc4tcvO/tOnRkC4I11A==@vger.kernel.org
X-Gm-Message-State: AFuF++kkxP7+6PIhRctvfPy6cA0BJRf8r2otg05jMt8HzhJrR3ZFtij1
	PxK/uruYU4bXwiz6y7rncWOwYoTvhF1RNVQ5LHiNav4zbt97vBQ3gbABME4hYBNMRw==
X-Gm-Gg: AYBFou3r3X+92GTo+x8uE2B2n4IU9pWXedyAncs7YjmhisE7c7eZvlpzVXXDMcxNJ+0
	vWWwu1KfwdfJ1mf33XqnI1L7Wr1SodRuEFeNlYxPV16ahq3YKRLLItudme/uobedIikj3YdbI1r
	JlfxV6peZXgJUtbcl7+i1fHwz1bixz+775x9voAPBrtMi2tmUudLIuz6sXfk2umUsYdWOPBGABA
	gyVFuD7nBsJCK6YsIhhRK7Yhgj3tyuI4BDSA8Dejqnm1HDRAmrfVykTSXZcoVzPMRL3Y1u9bReZ
	PuFkEoMLLxEanfco9AXNhV46X2AcOIOUuE07iRKe9+mf0ti6cwNFtt46n/1zDY9W7qimCzBVFDO
	VtJn9fLjP2uNB94AgYx0JEhGWt1sVN7H7ws4SzapYHoMKrFFht2lWmS2IShVgh1o36IF4VT68xm
	ilPo/tbwEyO8mPghus30t1ccxDJoeKSMjCSKBHuqX6adLfIUepZeI/2+G/DijqZUJ8GGDI2Rvc5
	f8CjO6xYUdpHhQQySKt4O8LM/4JAFmQEdE6EWU8wMDOiRTvOIw/HP+WvsPGrIYt5fOSYtKsuWtv
X-Received: by 2002:a05:620a:2707:b0:939:bd4e:b2fe with SMTP id af79cd13be357-93a29a12d15mr593158585a.40.1789418513279;
        Mon, 14 Sep 2026 13:41:53 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939ebda519bsm1046663585a.26.2026.09.14.13.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 13:41:52 -0700 (PDT)
Date: Mon, 14 Sep 2026 16:41:52 -0400
Message-ID: <506803b6b6c4a74551bc5c0d6e31cf71@paul-moore.com>
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
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Ondrej Mosnacek <omosnace@redhat.com>, "Serge E . Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, audit@vger.kernel.org, kernel-team@cloudflare.com, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v1 2/2] selftests/landlock: Check full ioctl commands in  audit records
References: <20260910144837.381855-3-mic@digikod.net>
In-Reply-To: <20260910144837.381855-3-mic@digikod.net>

On Sep 10, 2026 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> The ioctl audit test uses FIONREAD, whose command value fits in 16 bits.
> It therefore cannot detect truncation of encoded direction and size
> bits.
> 
> Use an architecture-independent unknown command with set upper bits and
> require its complete value in the audit record.  Landlock rejects the
> command before the device handles it, and the existing ioctl enforcement
> test already exercises the same request.  The new expectation fails with
> ioctlcmd=0xfeee on an unfixed kernel and passes with ioctlcmd=0xc00ffeee
> after the shared audit field is widened.
> 
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Reviewed-by: Günther Noack <gnoack@google.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Merged into lsm/dev, thanks.

--
paul-moore.com
