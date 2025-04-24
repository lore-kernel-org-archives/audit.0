Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4C21F4C8E
	for <audit@vger.kernel.org>; Thu, 24 Apr 2025 22:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745533113; cv=none; b=gJaHHngf1XiX9aSCqcMAh/0+8X6tK9cHHG2Nw7sILXI0CLfYgdPS0H6boxc5Nnxx3RVXOymQInYkxBEYdRzDo+a6BerGokz/QwAUw0kZ49DoOVoTmyFo7c77J07seja8Ojhd3/2QNLu8mVo/OTbMSMq/eGCp9Obce4UfaBprajA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745533113; c=relaxed/simple;
	bh=l4f1xNB2dwWSdrG9upCnzaeNTP8GCePr0kItE5AT2h0=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=SQhqh/llwjfah410feQ9SD5q9HrIdbsvrNAZKMatYnnWewXLl6gICuRjJxzshHo9ocOxhDKK/n30YWhFO4iyyM0HPALcvNap8tEac/c5v72kZeLTQubaJQMyt5RLIie+gm3Rwq5MPkZjudFC+LM694Q2oxFYfOPGnZVstitDq4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UPnInYH3; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UPnInYH3"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c081915cf3so226281785a.1
        for <audit@vger.kernel.org>; Thu, 24 Apr 2025 15:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745533111; x=1746137911; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=251+9C3n6HOhFKPLs3FnNVOnITQVSwoWuSTYkyfbN34=;
        b=UPnInYH3rId+B5sBPw0zXA8lCBZADPzWSRyQqsf5t8lwYqvuQVvPuReZ0XNwcfAlmx
         rCXglJDkAkBuHXRon4A4TNs4GnrOrq3LfncNhcKarTW9D2x3aRwoNJZZ2aOUpYf0Sd98
         doUUeaWtNBE1IS8yTA+GaNzXMA3y6PcwpCZJMtPxOtXL42SrwfTE/ngEUZ0SsFdTfd3u
         +yPiGM4ByJH++mMyC4h4lMCJGLYcfvOF0N1WJf86DibbP/Z478gJnF9fFojlwSHMPQ0j
         IFp4EvF3f/Y4OV+GJOrPMFoR2qQP5a2JRFIhFqw1jLEh6lxyIjR0VsAfTdk8Q1xyK+qq
         +hMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745533111; x=1746137911;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=251+9C3n6HOhFKPLs3FnNVOnITQVSwoWuSTYkyfbN34=;
        b=tGFANCd79cS1W9ioC2hKH1upUm1/47YHRaYoSYYNc3L3rxkzo9Y46h238NZ3TWggZI
         I7ifjJIgkxxIrMBQuSYMUxdcbB4o5g9zhwlpeaXt/TxMlFRMQfiZie/ZPh49vdWQtc1P
         KHriG8oBVxz0eUn8hCL0cm7USc+h3AyO5Rr9c/Fv3dtdfC6Je8HVYN3TKaaI0b1j0AqB
         vgKHoy3n+IvSzCGtrbkNF2S/xF7OdwyxNyWXAc4ko/esApY42tTRGq3wjiY7gVEXtPK6
         rR25fE7keEdyjvDYElbjqUKyqc7Yw2LfxRawyMY37sgilGEwz0cTk6RDv/+SzPRJwWIu
         4KQw==
X-Forwarded-Encrypted: i=1; AJvYcCV8bu/BaKVNg1dyvF8SCWvgmuDxjdsSp/Nej1zwvTLGD8GdARd7nso4/eXjyDQfVpxj0Mp74w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3HCH+GgGA6SRWFqFcG859AUPItqun6qAaBjdhyU/bwCUe0A+4
	FMpOvX88fdQFkyUVJqHnbYDMScLbbbLdCSUpXysbn1hkKL1gEs+3VnklvBOPGIDdI93oxZqu79Q
	=
X-Gm-Gg: ASbGncvfCcAUklhJAn5lvPzO5lj9OnZeXAFcC8KOHQZzIVmP1+RUJpzWDYVGDk5UG7J
	6p9kn5RIoiUb7CIpFEXEY2hRBJ4bGhOCOu7rBJNjFE6CbcXXsFJx1E9k/K0b1A8WOJjkh0BIZjp
	WFFw69VQymvsnpGY3bJo3J6gKaEa7AFL+xMGCH45N+X5lmcsUEQRDk/BtVnwyN3OnrnRglqWbFn
	B7zm5ZHFa0mc5YHjnN1GyDFwvvbTePJsUoauoxznW0B14DuRTCr6qMn6DViVeI/00maw+D2zBtx
	AdLp7Ro7qnSwML3gEwP8tEx9JRfCw/Tycy+5/x0r5XG326W6dT+toeb43bEx9gv7pB56n3QglON
	LQfFiUyYH4A==
X-Google-Smtp-Source: AGHT+IGCkjp7bhibsegJvEnhEdx+029sejsn8em3hGJ2OLmGOtsJSHM7xFwZ7JdT+eFzXvq5AWacag==
X-Received: by 2002:a05:620a:430f:b0:7c7:5ad8:aece with SMTP id af79cd13be357-7c960719efcmr44339385a.25.1745533111053;
        Thu, 24 Apr 2025 15:18:31 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c958c92193sm141850185a.10.2025.04.24.15.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 15:18:30 -0700 (PDT)
Date: Thu, 24 Apr 2025 18:18:30 -0400
Message-ID: <a64a1877ac344c22b3c86058e97d1d33@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250424_1707/pstg-lib:20250424_1742/pstg-pwork:20250424_1707
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v3 1/5] Audit: Create audit_stamp structure
References: <20250319222744.17576-2-casey@schaufler-ca.com>
In-Reply-To: <20250319222744.17576-2-casey@schaufler-ca.com>

On Mar 19, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the timestamp and serial number pair used in audit records
> with a structure containing the two elements.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/audit.c   | 17 +++++++++--------
>  kernel/audit.h   | 13 +++++++++----
>  kernel/auditsc.c | 22 +++++++++-------------
>  3 files changed, 27 insertions(+), 25 deletions(-)

Looks good to me, thanks for moving the timestamp and serial number
closer together.

--
paul-moore.com
