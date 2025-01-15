Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AA71DDC07
	for <audit@vger.kernel.org>; Wed, 15 Jan 2025 23:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736985192; cv=none; b=IsYutYRPyATL/8y28mCejmMi2hopHuN7lcbvsU9/IPEuBzYjC+T43GqCUES1qn6/Wd8JY06YKPnKNnIPp9YFNeiKCI0XcOPoqO0w1FMz56D6D+dVYUcffilGedsibGOFj61uiaB85nu+gyq8FPvmG2+Pvba/eu3DkCeTQY5vQyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736985192; c=relaxed/simple;
	bh=w1jIE9hJSQLAasM7TNhoYeU19kfzxbDAm9Fb79w17Zc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=mXaOLhip/0hH65YKKckltRrXFGKkDSmZZwnooExaqYm0+4oT/Z86IUkitYHLUwSGJdS8qr3dWYZDQObSug/hPgMBso+pu/MVYd/IGgu8HBhwD3ZpodYMcFLfQL6gUtQXwfVYPRMpbdCs7+2gLTyV6qQcykQMN/uLhwW2m/a/5hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eWmB2uws; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eWmB2uws"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6f0afda3fso32638585a.2
        for <audit@vger.kernel.org>; Wed, 15 Jan 2025 15:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736985189; x=1737589989; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJh+T7Hv8PTpEPApQXjKvV56GIOkdSD6Exn3cyfJMsI=;
        b=eWmB2uwscZSkqgcsmyAUiGk8MXYioHcwTTK8Z/FmMZ9zQWk1D3ZUj66GpT9p49yyIX
         JS2GBqfR3fwi+MlEmz8+HKQ2jdw4Z477SDyvExFCfbR62qlZJSIgCxz7HneNl1VG0/5u
         i12lNmdYkOaF4suZi6ohihiP69DmdIbNkyV5S/xF58Ye7xsWDHgjXNaK79vhwpa+jrr/
         fDq66xBFjVZKvIJ2sC6EXEQUdcEFAn1NCiMqIhvWSbIUxqa6XFYvOs0bZvFhWQ6F+wtO
         4oj9ie3zRIP1XFrgLYt/jeCsyPDvm4LFoRJ5a4azTbfEATxnVEUn85ocvKJkOca7crY1
         dMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736985189; x=1737589989;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bJh+T7Hv8PTpEPApQXjKvV56GIOkdSD6Exn3cyfJMsI=;
        b=OKkfDM5XSGicgJlvHgHtbKAvsw3MnqPLAA9mgVuhcCCQFC5uF1Ik+jcak9wVHU1smT
         I0XbjRquTDz2/yNNEaUVXysG8QLTgofBRuAS7fSKFINumrXnMLKToR/DqRXTSM2TQ6Dx
         eln/3IFr35bIhX/OX4WFNWEGJs6//uYn1AZqvWdvMaU6/O9fx4r674+jDtCevKDDYAGY
         LDKmF6pEW9RWFifdL1yBZoDXA4hb9p1Kgdh4KP1Hlk4KYYCLNcB2d1YOYgpeDradoY4w
         RqXQE2SOzgRLttLaspNtNSc2j+zLcXSGyYm8AcNsQPQlkIb5pl5mrsdLjd7DfeZ7Xi8N
         Hi4A==
X-Forwarded-Encrypted: i=1; AJvYcCVwykQ1c7W8ICi7fP+xWVTmSxS3xrH+ho6WlFKdsk6V2vE7N47zS17/5wMlYfD1KsKw17jcvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiHsnXn9E4PjBq5GnnZNmh1TC+MOEDlH7DSaJCrltqXkT3IvFo
	v8ivX16wwpurhRTo10AXIfGxxNnKgB4g3C+NGogkh8v01KCmbuawSnVhpaQDHw==
X-Gm-Gg: ASbGncsuGAO4G60elgW4YmPFB3RjZZOkDeTEurnRCfhuPFmWw3iM9A/M2OTA8KbF98k
	ISCUVZ7SJ9KIvFKBI/MM1QiiwgfEfjyICKBafzPvi/eWPWOUmSUZZzXt6AUCp9QqhywEFlh6/gU
	wn0wWVmV6rM+EmSP46hsMx+yO7PTdVg4+b3zOymbaJz43e6JConybLJbLLnknPU/85tidxSd/ih
	VVMNrLF/HZ0S5+K3fKj57yzx/TNUZm/5SEhIxcXrFfrYJ+O9vM=
X-Google-Smtp-Source: AGHT+IGlGPvAT10vh7zR6GchXN0fLnmopYZatnQZSEGB+wWm79pzK4V/AiofLks/o3AMcVKKkQY4vw==
X-Received: by 2002:a05:620a:1793:b0:7b6:c93a:7f2f with SMTP id af79cd13be357-7bcd9709142mr4501376085a.14.1736985189359;
        Wed, 15 Jan 2025 15:53:09 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7bce3515f40sm766857685a.99.2025.01.15.15.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 15:53:08 -0800 (PST)
Date: Wed, 15 Jan 2025 18:53:08 -0500
Message-ID: <1ac8548a7b42eaed3f4392690011eb8b@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250115_1512/pstg-lib:20250114_2216/pstg-pwork:20250115_1512
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Eric Paris <eparis@redhat.com>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, Daniel Burgener <dburgener@linux.microsoft.com>, Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 28/30] audit,landlock: Add AUDIT_EXE_LANDLOCK_DENY rule  type
References: <20250108154338.1129069-29-mic@digikod.net>
In-Reply-To: <20250108154338.1129069-29-mic@digikod.net>

On Jan  8, 2025 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> Landlock manages a set of standalone security policies, which can be
> loaded by any process.  Because a sandbox policy may contain errors and
> can lead to log spam, we need a way to exclude some of them.  It is
> simple and it makes sense to identify Landlock domains (i.e. security
> policies) per binary path that loaded such policy.
> 
> Add a new AUDIT_EXE_LANDLOCK_DENY rule type to enables system
> administrator to filter logs according to the origin or the security
> policy responsible for a denial.

For reasons similar to why I didn't want to expose the audit timestamp
to users outside of audit, I'm not very enthusiastic about expanding
the audit filtering code at this point in time.

I'm not saying "no" exactly, just "not right now".


--
paul-moore.com
