Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F182D6407
	for <audit@vger.kernel.org>; Mon, 13 Oct 2025 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380817; cv=none; b=js/qyg+7rCt2cchpDB1RKtuDEePJHhlWmJU5teWxGtxVuk+GQWJcLzUrj3axYui28qZs1rZDJZVaktkgQKY8WeVLphMBIuTrn1Gla0hCMrvEsdPE4JNNz2132IS4Kux5ciS6AfZqCqguz157fMjXAwg1h/HzlDbtGLTt+BDVbrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380817; c=relaxed/simple;
	bh=fvEL5X0zqBk8iunM0o332HEpCMC2w41HMd6F1GLdjjs=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=d7pqEsHyykqxNGupkXZ+I3irWk6PIvdCkYClvywuOVhZkMjp/Dwh/MxGfOMJPe/1M1qyh+c2jxbZTcIUdeyO4GnpydclkA7uje79cFGHpo9YR3pBzPkdGvTaTw55g4JiYejBbZNxYqSqwc+IG7OIPQxV5kRpBJ5noFqeiYJEGCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gf9WAom5; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gf9WAom5"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-7970e8d1cfeso81303446d6.1
        for <audit@vger.kernel.org>; Mon, 13 Oct 2025 11:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760380814; x=1760985614; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=otoedkFMmi73QYZCpNw6QjUVY4scWdaY7ZmK0AImrmE=;
        b=gf9WAom5qrLuppoOp57bEJ5Fk09Mad23/qpxilBTOjm69LLrMJ8oUVJqxbM97Rsypl
         554UdRx4XXLpoIX/MdzmEs/sp4FXMYlr3ehQYWkb/3KvuIEY+2/2v6YAtpXc9oSlc4EI
         yZ70tPCQPcLL/x+repJ1vNQRixS5ELUElsg+oiTxVRtzLUOvt99mrpdCeQ6sDUIxmlmu
         gjcSAfyXzaM6AXPHwUVEIIh4d5QtMabxIQG+NDCQQQbVncxfCqae0PiJ1fzF+wxmq0p0
         0uXIyJBZVb/GST8hfkXgIYZ6Fqwj0NNW1VjRhhCbEfPPxPNhcdn2E+ogLmLNujTPd/aH
         lnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760380814; x=1760985614;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=otoedkFMmi73QYZCpNw6QjUVY4scWdaY7ZmK0AImrmE=;
        b=XZS6QirfhJiYoLRZZo5lXjVMBuCwr/J9vsvfkBWcARqP1NUB/JT7GKn1+DeJVl9I0f
         WrAlKN3ZAYmUM43V8/z95EqEMXrZoMNWvV2va8zTkIsCjBr6w18laa8smMQfShJ5HpHh
         Khjtx2uYrASVWrBkGpAGKV3adnJo79oP42CLgVH4MgmJ0AAumfK8dQTxa39zeqnEOQdK
         kQ2JcqyW6v5pKQlI9iJnLvALKtFVIQvXGyxsldNMwKOgzI9a9XN8J83LWIv5+xdWMzuK
         DdkftlR/N7bsyWvT08sBtvNLpAP2bsdpaKuPwAaErES6KDIuACjcddpO3xSAOjdmxYgd
         zkrg==
X-Forwarded-Encrypted: i=1; AJvYcCXJrTVUswTeXHVhF9oPAy1Kb1S2+IHhtnPwkEKFybAZBLbSdbd1hrKQJ1PKHTXm1sgMVhEObA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/4IhwKujZ0KukfgBSlp1SBK2Jw5XBstUT/ztRqV/vy7Eaca0t
	al9bPnZh6ryzKT0W5zPK4ASbvBruR5Hv7oxQ8ekb+huFC2gTAm8u9m4qRo7DIPljhA==
X-Gm-Gg: ASbGnct8G5ZQNlM36C6kP/ASgwKoZ7soo0zxQTgcDu3D1qNLiQFJrZp7b/EYTBse5Rf
	/+HWZOIWGooEA03xhKGJw1SzGmWzz2qLvH8POArbIGbEz/hiExNiDa3CsbWiYh/OCfU2MDzwUPV
	zkX3n3cU+lAqZheAiMnJfZf3q2E7tjQtOr1lRx7tdxFYBVfrkMdwJzeECnC4wu+DA6upgFIiHIS
	Kiuk7ol5QNhnpsxNu1xG0hFrm3Nj6u8SbUAVYtF0WZS3jDrdbgD75DJnNoq2utLeI5hiAD2EPbL
	Z0Vb8Qevr47lJ6wuE00fqEZ/druiaec3yo9Ud3L9FfuM2Evm+OTQzMtdiMvVd/uUTOS9oLYMeT8
	YbOpNWbBB2s047NjhlYEskXMm5MqE7GpJcE1VAeHdg+hcJx6jC9BMOzei+8nbLSaz+W/HI4NCGa
	fvjqrM8w0MZgeotznUltnht0qlI6QSbG0Y
X-Google-Smtp-Source: AGHT+IHvjx1SEnBpdhEa+e/tHGVrysauD0Tv+bE0OKhtJaVJhTYhnMFVSCFuMzhnNWWQ8wz3N4wCwA==
X-Received: by 2002:a05:6214:1bcc:b0:78c:655b:b30f with SMTP id 6a1803df08f44-87b2105ac61mr317191456d6.30.1760380814262;
        Mon, 13 Oct 2025 11:40:14 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-87bc346f6e8sm76509526d6.20.2025.10.13.11.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 11:40:13 -0700 (PDT)
Date: Mon, 13 Oct 2025 14:40:12 -0400
Message-ID: <586cc14d04810b3154d2eda25d6b06a0@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251013_1430/pstg-lib:20251013_1119/pstg-pwork:20251013_1430
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH] audit: fix comment misindentation in audit.h
References: <20251008142719.2564034-1-rrobaina@redhat.com>
In-Reply-To: <20251008142719.2564034-1-rrobaina@redhat.com>

On Oct  8, 2025 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> Minor comment misindentation adjustment.
> 
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  kernel/audit.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into audit/dev, thanks.

--
paul-moore.com
