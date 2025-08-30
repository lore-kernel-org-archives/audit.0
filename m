Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C043238FA3
	for <audit@vger.kernel.org>; Sat, 30 Aug 2025 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756563296; cv=none; b=p22CwCB5PK6KMIjlkhCMkdL1CoBxObx2m9CRscF9cOaz9somoDsES9Z6gtn66vYvQmLKYDgPErLM5B+TW0HUhoaBMnF/sdAmFJv/JDp0tuhldAcq2ElYYdRLNwgAnVGX+A6+txJFRbIF9vrJCUaTSV5YBeF0Ra4AggmP/gXq9W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756563296; c=relaxed/simple;
	bh=NLarFhy3kQ/TjCF4gbAzrkvsWHYogEKJLhKX1GQRe6E=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=BISYdP1hVjkbF1IkDOUXj/23rVh0/6lFv4yRTH3fl5p4znf3ZSZw8bhgdG0h/ZrJehS3iCbipHl17ypLFT3JQYG50q4ejFCyyeIJvuNcQSi1vwbVdXz2SA4yj+nFaUqG1eV+QUQf/gpRIwyAEyGBQbCjWQ69fZXUM9Y/oOZa7us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PzTO+rLX; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PzTO+rLX"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-771fa8e4190so2023740b3a.1
        for <audit@vger.kernel.org>; Sat, 30 Aug 2025 07:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756563293; x=1757168093; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vhRNtUPsZDFJYGrztPkjMPFnVe+Rwz4ScA0R7wbO7c=;
        b=PzTO+rLXWFtNInMn5cl2f5knPnOvyE8e/ZqjD6aiCCgQ+BqEwHDYo2HM/3A5Bp3ZZy
         kYJ8hDu8Ienhgrt1uHtN16ectKQmQN08h8U2JrVHJuXTQ6jnCisyevIRb9LNG56KJ7oN
         j9nGMxcgPfM/4aK6n0gGcpk91LIAFAwD81DpLOkPe8CIUGHcG0gAPew+VP5xXWRp+/oJ
         13bFkvkb0Hk2b+Zp87AaWQUa4siq/7PfpHEC/vTtqCqxPZSIK7weWF5prqkbRimVzCQs
         1jE3rlj/30EYzDkgEAkf6paZLUkCmynYaNk/jQH8zHBcHE2K6C+gqg/WV6lz1lY/VXVe
         YRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756563293; x=1757168093;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/vhRNtUPsZDFJYGrztPkjMPFnVe+Rwz4ScA0R7wbO7c=;
        b=HJk/udZloiwClhvA3rnS+NmgTB5FZNdNklnsM5Vmt83PviCtGEUzydQxhaKVeOrUU3
         7UYJH/FNS4Y9uc1CnQxA3YWmjjkMd7m4LB1fwnR7KAskvyjZ1gWdC2lLhCZMP1rneEcS
         04hBPBs7X3nBCyVJUiAgPkTt3NJu54J6zJfDybOsEHfx/u5etzMZDdPsTLMHr9lGZK0+
         0dKk570xNBLbGKC9U/UZ3pzVh4+JUTt3ZpVG+Z2Yfgb4OslifMyNkTPfzUANKTpDsRnq
         91UvxyuKXnSZ4E2WhzV0cjZAEdmATTxmCFRdRC7GXa3Drc4LWUsAUQfqqIoHWr+uE8c6
         g+6g==
X-Forwarded-Encrypted: i=1; AJvYcCW1+LXg0BkoE4B7iF0h4ZAL2l1Z4B14fujRt9Q7Fi52VVnJJoQvAOkVZLlMyI96TEpnKAPK4g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Mw16XPdtURl47JxbhBra2QK5K81cAlcDWtBx3uG5pWgwA5CD
	o7TeUyGA5WN90EEpViFqSp6i1rax1sTnY+GdBFbYJq/dfbrAP1iGFQBv2t0C8z6pKQmsUvzFlg9
	obU0FMA==
X-Gm-Gg: ASbGncuLlQZSoiRSd4qh6vWJLee+hAgaKZLd2rzzZeow0fUG1vBMmQ0ypAfpzKml1tl
	6Of3ND5Ge+es7uDeNAtFh/yb4WGR4yO8QJJwWp5oz2KhsC5KAatqVpL5xO+dfCYDYeb+3Enws1s
	ZHC2pm54oiVmfddvRcYPXLIZeZjOQ/fhRH48MGG6tLzS9l8qRLuSZrMGgP5AmM2f29H1K+bOyxt
	4lYx6ynNS6gnonsGQs5u4ptwjaY/Z72mdDIVkasvICO/OmP8Vo70KDPYEQKjweKwQYbryzAFZ/e
	TsJYt6Bqg4nG68ZbVO1oNQAcUo760PPd1CXZ1kRJrktU9C20wB2H98Y5am/VSVdMiiHG7ms6j9h
	zhTuYBAxx19POVA==
X-Google-Smtp-Source: AGHT+IGXGDxudBPOQGj+2n/Xq4JGPNY8rIEn5BPaZdBF3FLtxzrLU7/7VkCvAu8X+BdRWPuL6Qz8AQ==
X-Received: by 2002:a05:6300:210d:b0:243:966e:21a with SMTP id adf61e73a8af0-243d6f0b8a2mr3512373637.36.1756563293102;
        Sat, 30 Aug 2025 07:14:53 -0700 (PDT)
Received: from localhost ([205.220.129.22])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3296c8c11eesm1319169a91.19.2025.08.30.07.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 07:14:52 -0700 (PDT)
Date: Sat, 30 Aug 2025 10:14:37 -0400
Message-ID: <e6e9ea4bacac5553810f7963533a71ca@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250830_ 948/pstg-lib:20250830_ 845/pstg-pwork:20250830_ 948
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v6 1/4] Audit: Create audit_stamp structure
References: <20250816172859.6437-2-casey@schaufler-ca.com>
In-Reply-To: <20250816172859.6437-2-casey@schaufler-ca.com>

On Aug 16, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
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

Merged into audit/dev, thanks.

--
paul-moore.com
