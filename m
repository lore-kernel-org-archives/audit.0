Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4961D618C
	for <audit@vger.kernel.org>; Thu,  5 Dec 2024 23:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733439968; cv=none; b=QarKbpqmHI8rf0MpITWANymseRVYKGGxK5Hgh8XPgBMOXO41CsPFmbx4JsrUVBrFRQPBr1+WDGiiI8QPdVf+Lm9GAjfXT33ckjB2bdI7EBytAffe2AUGqJeqgeTDhgB6xOX+iI/in/Yu0uWyBnztx+pH8KPVfmj+zAfOzLQSorw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733439968; c=relaxed/simple;
	bh=RSRtkP+Fl4Fu1wv2TYijQ4+N4uCrLGYJmNgMQkiMtOo=;
	h=Date:Message-ID:From:To:Cc:Subject; b=Maz6Z4F8FrGxLb7xzm5jMVciYLf88PEnOblCYwtZc/u1JUsqcrGs75AAzyQhCDMyOaHQZbPGnY1MTDE05yiQ0d2rd5dQeKgRsCjJefzEQYmt9ci/0ZaNEqJtV2sZdejNFJW9Ur507YaUCTwimRPsHRV8Cd4x/4ZnuJfKFOcvX4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cZEf0Ahq; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cZEf0Ahq"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46679337c24so11133991cf.3
        for <audit@vger.kernel.org>; Thu, 05 Dec 2024 15:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733439964; x=1734044764; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gB2wprHKOPR1C3FlWr0JxgyEJMDu3YBCaXKrSKkj2to=;
        b=cZEf0AhqaHnk1Bs5gZ4/uADCelK11qH12xO+5Eco7i+9xeNmjmY58s3OC7ujlqAjPZ
         wnifc1OYOM2uv2MyHx0VQmbcas/hdu1AQBa1Rndceqn45F/uIcOvkDOg2QnKEnWZHZff
         /wAyzlJS84dVFoWcBtrRBRCYLw2FEzwkLM9MwNJtqJhG8XpgUZw3zpoKjQJFmok2z7CH
         yUYokBliUjnGwM/4JUXVZrXO63/TabhUlNfYIz4lYFmOiv3Fvt3RMIMMl/mbE8Moybu3
         mGtFVKQWrHkqBL5wKFsW7Gz2zqk9VVoeOZ4BHlvoMLYCHoT6ivEUlAoyQya6I/cQgFBU
         mw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733439964; x=1734044764;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gB2wprHKOPR1C3FlWr0JxgyEJMDu3YBCaXKrSKkj2to=;
        b=e+Ihreg9ldYKtop3KnLQxDBCr2iKShF8oo9IPJ7ev6QzbbbWc2j5ObfC4IJluKx7H0
         h7AHM2we+9qtmlffDPOmu783HgTg94zyD2zCj0F27uoWrU9chVd81qtThaq7czd1rteG
         /j4R4jFBL4L4qJZep7DPYZZn8Tur0ybRxxzbcw8KqDW7JwmOrcdc4Ek0ONfyGOAE5nGF
         lELDETBbKH+Zq6moJ9Fjj0y6LJZJ07izr9PdUVVfzmd6lVu6uKgsf0Hvow9MeN1Z0Arj
         kovlwDUq0UpRF6TI0hkYdlyioGBHnpxn6pLb77mqigbjQMEvEjXHE0GSSCMQiHeMrSFP
         ScNQ==
X-Gm-Message-State: AOJu0YwmYgXO6g/uN3jiLGTlCR+cY7nqGAeguRYIdWIt8ISKg3V6AgSX
	HJDKWgccMXKcooX35d3nT/ucpw7w3GK4Tx065gAQ8Yf6f9hc8Fkt3j/8T/z6ybE0IJyAgR2hPuF
	vvw==
X-Gm-Gg: ASbGncsj9DiE0k0ujhkm8IFrnC7xtM5jMujKnQSvbEqjytfSvfivTnjPyro/LuiZk3Y
	oXy4UqrEDJyb4AjLKzIkpYpAJvvng57NEvCTZ7u7+D+03DZKDNE1Ew+tEjVmzmzyyiM/ss3g7Yd
	mGZhNcomBlWxxyniA30b1LwVaPkND+Cw0HwMBpyqJlrt6ErWbVoVVOV6xhijyQ5j7lkE9dVq2YO
	axLW3bjlKzpnk1+VpBx1Qe0chhtq0FbM2whtBfK+VxK
X-Google-Smtp-Source: AGHT+IH//YJCxBh1r9M6L58qveosoEAxtWbi0tzDXcNc0u1qOZiSVBYlKljByQTou9Gs7CfnatzY8w==
X-Received: by 2002:ac8:5955:0:b0:460:996b:2896 with SMTP id d75a77b69052e-46734f48cf2mr12049091cf.45.1733439963780;
        Thu, 05 Dec 2024 15:06:03 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4672978dd14sm13184221cf.54.2024.12.05.15.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 15:06:03 -0800 (PST)
Date: Thu, 05 Dec 2024 18:06:02 -0500
Message-ID: <70abed262882f79e63e747ef56a0379c@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20241205
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

Linus,

A minor audit patch that shuffles some code slightly to workaround a GCC
bug affecting a number of people.  The GCC folks have been able to
reproduce the problem and are discussing solutions (see the bug report
link in the commit), but since the workaround is trivial let's do that
in the kernel so we can unblock people who are hitting this.

Paul

--
The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20241205

for you to fetch changes up to d9381508ea2b590aff46d28d432d20bfef1ba64c:

  audit: workaround a GCC bug triggered by task comm changes
    (2024-12-04 22:57:46 -0500)

----------------------------------------------------------------
audit/stable-6.13 PR 20241205
----------------------------------------------------------------

Yafang shao (1):
      audit: workaround a GCC bug triggered by task comm changes

 kernel/auditsc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--
paul-moore.com
