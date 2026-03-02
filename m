Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528CC282F1F
	for <audit@vger.kernel.org>; Mon,  2 Mar 2026 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772487640; cv=none; b=gGs9u7HTcuXZ65d9Z6seGZQYWsR90onpjKUrRSjZyPfS/C6TI9Kok2ygI2gNZpDz58cYPPLmloqeyDhBD0puknFdMOtEF8qaxApRrjP1hU40SLIPnw4Foyd4ODQaErGwdmy+93tna/cAEe8Ts3vxqMdj4lljxcTTRKOrfB+9koM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772487640; c=relaxed/simple;
	bh=JjtuDCg0niWOmejJh0UG3WBDTsenifPtts4A5vaSDs0=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=uxqxTAlWXqLyjn+qQvCFHNTEuRPo/DJ7PhqrciByrtzTSkL/vM3uBh58aJt3pH8hu2xxDP/MGMEfs4082Fq2MHebKCo2j+EU+6YP61gdsyWJHowd3iDpjkLPoMVbsZxoPGOyikgHN9F3PbilyW2wqoHhd3QPbFVF9SS4En3Hxes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WyqAVw/1; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WyqAVw/1"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-899fc9853b7so16883546d6.2
        for <audit@vger.kernel.org>; Mon, 02 Mar 2026 13:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1772487636; x=1773092436; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tqn5DO/sAQX2IDn7rlx3SR+INsmIuJysGd5YtipKpY=;
        b=WyqAVw/1raMVHsBsq04uSJIkNLQChsuL1Feq5/gdtnlG2Gu6TAPhMw1npKav5huhzv
         JONBEiUpvNwk+JCykGG1G7HuTfpTu8fbxHF67v6GILla1OMu634C5+hNur2QQ+QfBArn
         O2GXLpsjEuBWXwm0ldbnlsV/cjV4cus17NmTGqDnD/Af+/KHllS91LrXEZhSkG7ETmIq
         K3A+7yQvo9yLqkVN5Tzhw5AAUprPK6OtxaO8YEA0JaI6Qy26E2nTiYBgV9IWlWtAeXOr
         E4jLaSgmeprQdWMUlihUWrM3opJOvvSP77fQTRx7RODYTI3S2ic7sH8EPx2vhqH30Qu6
         CU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772487636; x=1773092436;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tqn5DO/sAQX2IDn7rlx3SR+INsmIuJysGd5YtipKpY=;
        b=MuZRGGsIwUWkewqY/yhnROn+l55IIFNDv+bFuclTgJyR1g4BwB/G6zRduFHQyXx+Sd
         UTZMnr8pIl/xxKCVvuRXtqDdxYSGnrJLv6USWwNbjdqGO/KUTqW3jNxu3K+oxkaTR+md
         xJnwHCvI6Uooxs15s92XzL3NhsAk2X4BSsvEFDYfT3Jwgc0YtkHWcJNbin2Nj/xcoUhD
         2n4dxTc3aefZvFTP7fTmMYTaFxVUsrDqWOiW60YN2fvUXDUKBgDpkNBurdevTqZXbsEs
         gHc6Muxdt0m7F81x/l58RyDHC6e/O1UN/gjjXeGeJGTyUDMQvKNV0lSRutQgc4R28Ajn
         4LAw==
X-Forwarded-Encrypted: i=1; AJvYcCXUEO+5THISN/kY7wbB9/128VfinxCVRnWRt2fMFWptdIJ4ygOq/zD7LDWVaez485jaMYkJJA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh4WCs9yMVm7xi2hjviULZKo7HAEy+1vH+lUrhUbb+SJhF2w4i
	moxTEMwTFhF27ALP4pCRnByxXUO5zhBsJtlN/2VmgK5q8kclpRYzPJeM9izA37baFA==
X-Gm-Gg: ATEYQzx2dTePG+CzWaMYODoBgQQ13+UFjkn7kPIzZCEkDTBb/HJK/sSXiTzgGVQx+Hn
	QcTIyxjfsB3b/lGTR2jQMRHzM8Uw6qhxyoTtSR8ait8+VoktujgY82yngEcqPEl3it6sWPDE93F
	bZ6c/J61tDLmOOOBkNxJi3V451qqHjk4O1sCBNrZUayvQP+PY83ocPoZOYElW7DHd+FfjtQnX84
	bRpsoxRRyoqTj7Pyrs1ggEVu66r4J2hcHCGSpofPD3GK7axSTxL+EuVm2yofsjT5E2tjpua+K+F
	Pvm8KIGa5yDkU+2apo1nTJt115QkZm+8yghFSkGNCNtIKMzm/6sri1Egm59po7zXbsRHnP18YbE
	Jrz8OI43Lej0W86wx2gOH1HF5SghGpsX0nSK3ruAi8muypNbRslZkVPm/BhgUJ0kAXS8MgFrexJ
	1NtKjEnZX9TfB57HdQ0cy4RRWWPdaNmkLrTdeTIxIG3ck/7Yh/Y6AdbNQHG4xeK2TsfyUx
X-Received: by 2002:a05:6214:5190:b0:899:f6bb:24d2 with SMTP id 6a1803df08f44-899f6bb27damr88020686d6.33.1772487636191;
        Mon, 02 Mar 2026 13:40:36 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899f71fa6adsm37816246d6.49.2026.03.02.13.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 13:40:34 -0800 (PST)
Date: Mon, 02 Mar 2026 16:40:34 -0500
Message-ID: <c0d6360d2ad56225bcd3b3c8fa196d71@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260302_1612/pstg-lib:20260302_1053/pstg-pwork:20260302_1612
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH] audit: remove redundant initialization of static variables  to 0
References: <20260226181338.2526777-1-rrobaina@redhat.com>
In-Reply-To: <20260226181338.2526777-1-rrobaina@redhat.com>

On Feb 26, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> Static variables are automatically initialized to 0 by the compiler.
> Remove the redundant explicit assignments in kernel/audit.c to clean
> up the code, align with standard kernel coding style, and fix the
> following checkpatch.pl errors:
> 
>  ./scripts/checkpatch.pl kernel/audit.c | grep -A2 ERROR:
>  ERROR: do not initialise statics to 0
>  +	static unsigned long	last_check = 0;
>  --
>  ERROR: do not initialise statics to 0
>  +	static int		messages   = 0;
>  --
>  ERROR: do not initialise statics to 0
>  +	static unsigned long	last_msg = 0;
> 
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  kernel/audit.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Merged into audit/dev, thanks.

--
paul-moore.com
