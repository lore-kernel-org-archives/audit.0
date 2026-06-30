Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECFE472760
	for <audit@vger.kernel.org>; Tue, 30 Jun 2026 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849512; cv=none; b=h1CJGBg6v6tl6jMv34XhTWEdl/PrKsrtUfobl9ir0L+4VRx6ajtNyR7OkbG6CiZyunDQxkA8KVHLfFHqFZrGnjyFnVMEre1n2OLrNdv8ppNlwaqOklShE0twPRGZGpvAAU+HON531Xpph6KLfuHouPhpzJcAoGSX4/FyBaHWTO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849512; c=relaxed/simple;
	bh=4nYJG1YG5AoiVmrUumv2zgkEe418m75IRGFi8Qt7DuY=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=oTG1rHNjq3Tyt/vVDcs3t/b6veqTsH8DwTZbYFSruD6aNybD0rOkWTzgrHxq5tlEBo/oNjSSH6tv8rI2WcftO2a+LB6nReejLjMpnoKW45O8E49gxkJiumxkJqxg07R1TIlOYphAtJYGJ5IRzv7D0IPe9j3fzx7sS0YoDHPRs8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OxUtO3NH; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OxUtO3NH"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e54f8c051so179147985a.3
        for <audit@vger.kernel.org>; Tue, 30 Jun 2026 12:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782849510; x=1783454310; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0G4JtKNZKietXIX7cSX7DaLFUuZ0+QvM5uhq2BtGSGU=;
        b=OxUtO3NHyANd/sF4kSlmMpZPr5HRsinLTemjiW9OJ+giUIuoRJxnNsW1NfV3YFoynB
         HStDBYL6QSZuuJUXXBQiBtxKfY1ZCrWBbcN6ICmhllysIt2ucOsWKMFLeK6Uz9CmxsDs
         qoF1h/G5l+1N7rNLxr/q6zuvzdXKEVHcZ0kljQmS18xgYQTu5xj6+uWGr34vy1Y+s7Xs
         NEy0yTWTIw4m3e/HfX9wLwOBdLsKAfZlCiQAx1QKXWCAzbe04hNbniHkjwHOORShn3FD
         Xoj6mGxM5GnaKYirEH3GekPO0YXd3PpEuRBB2bre2vNcF4ltf/yeSMlEj6EYaN0dHIsM
         XxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782849510; x=1783454310;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0G4JtKNZKietXIX7cSX7DaLFUuZ0+QvM5uhq2BtGSGU=;
        b=sVLbtJ73OAWi5h2sjBzc/TkL5ogT4OdBG4lVtmARRAKmrT50SNxYLflD/KfUjK/Dbz
         w/FFDe7UUYhSdSQ5lKPZHTEgRttEXagbDCU4UOiTkKtIAzySXXH96M1xP0diqxu+tDdz
         mnNrK/wS24hVCuzwHAC9+itzos67GbZIjBDF1zu1ukP7+X4xtfK0h/y6YOXcXgHmhyn/
         GfFTqukMjN7IhhZBTlq9srsLwvi20sswbsvKJMvDhaXZTfKwHKoe0KlnnHbWATup9mlk
         uRw41qqGolek+Qtlg4pICpgHHE1ZmiETRufRS8JJbH7ORyQ1hxcmLND6ch0I2AZf15aP
         Bv7g==
X-Forwarded-Encrypted: i=1; AFNElJ8sSqij94HJYCf40WVD0fCV3pB8pATSkefe0sNRVf0uX42GlGf3H+Q3+wuMrWgFcWQaNWqu1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBfuYiRd5IiW8AYvKMtz/R3d47FiFuJlFuBtmHvzvk4kkRI/2b
	GkZYZQLNP60zqByetXw4d65QYKMjIDBWY4wL+jLMoBkhHhQtxNeOhq+2Yx8jhEAVDQ==
X-Gm-Gg: AfdE7ckh1Xe5jv2lk6wgwNd2jUR8TrxRaGhoD7oi2PEi4ddK+0bXTMw8hEuxwfenXYF
	7T5BhV8BnopOdVQZyHhagL9ONz4LX7PjykQrGL/EZHngK/ynzCpt4osbta5E3y+9d6FnXrQBeiP
	78BucBJbKGPmBbwbzaRx9RuOkMctTQ6m9so7t1XAwG9Eql8zPfM/LmTvhGeJe3t7mgMgjB9/ONj
	2LYUFqPgxkpzLygSdP5wgCmucj5qgCCVOJEWBZ15BjFJ0ZGuyFishnJeh3UKRwgJ/A6ng62qeBH
	B5Xf/K6Mu2Ia870R7usvtqscdJv6ls7C0ChNPpC05hoR+WlgOemEEHvYf+3GRPYS0bj3Q14OjpR
	Vv/GeRlJb3S8ltUgPeot4XrSfp6McgOt9UxJQ0AeDUixP3HR+WlKCQg9vz/AgY6MQ7ABAf6pj9w
	gjof0svsUCovqi8cFT0Ksvb/dteXK62DjzdB4e65OfghZD1guBzFwA69GZQg==
X-Received: by 2002:a05:620a:2b4b:b0:92a:36e7:64fc with SMTP id af79cd13be357-92e625fe7fcmr818474485a.25.1782849510519;
        Tue, 30 Jun 2026 12:58:30 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e62163f34sm317497885a.12.2026.06.30.12.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 12:58:29 -0700 (PDT)
Date: Tue, 30 Jun 2026 15:58:28 -0400
Message-ID: <a12cfd8a21c2b8a51302a28e05c924ba@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260630_1523/pstg-lib:20260630_1303/pstg-pwork:20260630_1523
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: eparis@redhat.com, arnd@arndb.de, sgrubb@redhat.com, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v2] audit: add missing syscalls to PERM class tables
References: <20260612141436.3137694-1-rrobaina@redhat.com>
In-Reply-To: <20260612141436.3137694-1-rrobaina@redhat.com>

On Jun 12, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> Add missing file metadata syscalls to the audit PERM class tables,
> addressing gaps where certain file operations were not properly
> classified for audit rule matching.
> 
> Changes:
> - audit_change_attr.h: Add file_setattr
> 
> - audit_read.h: Add quotactl_fd, file_getattr, stat, stat64, lstat,
>   lstat64, fstat, fstat64, newfstatat, fstatat64, and statx
> 
> - audit_write.h: Add quotactl_fd
> 
> Architecture-specific and conditionally-compiled syscalls are guarded
> with #ifdef.
> 
> Signed-off-by: Steve Grubb <sgrubb@redhat.com>
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
> Changes in v2:
> - Added stat64 family syscalls (stat64, lstat64, fstat64, fstatat64) to
>   audit_read.h for 32-bit architecture support.
> - Dropped timestamp-related syscalls (utime, utimes, utimensat, etc.)
>   due to potential audit log volume increase impact. Those will be
>   addressed in a separate patch after closer investigation.
> 
>  include/asm-generic/audit_change_attr.h |  3 +++
>  include/asm-generic/audit_read.h        | 31 +++++++++++++++++++++++++
>  include/asm-generic/audit_write.h       |  3 +++
>  3 files changed, 37 insertions(+)

Looks good to me, merged into audit/dev, thanks.

--
paul-moore.com
