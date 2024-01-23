Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C18A50A72
	for <audit@vger.kernel.org>; Tue, 23 Jan 2024 22:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706049308; cv=none; b=tVmf6Wm/uRAoXnXG1zfQZQGtVsPjmHMuv1bmwsv8fntfiziLQeBbR5+svVuA211Lth0BVBEsHtLEh96wBS21TRIN6rGZhBFHZRZNaeHk/6ypDEvCsiw7s+xEuyjdoM7jcufwG7VQd2Dcvu7JUxD0SywK/BevgekScFDKMEipv5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706049308; c=relaxed/simple;
	bh=2u++mubrvoB/DCcfBUyd4IezIX9nayfVnU+6q0UjW4w=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bxRkY4JZmRDWlWGaXXFn5djfqbtkSXjt6P4UPIrGtGj3eWaNHBqx5NZR/mQh957mOdt0LAXtnwRlqz+eP0EOjnYmIgsjQGFwtxbJ0Aj/3NaxkI6yGu5t+5nX4vZCItuLVSgdqCb1UJi4L62gZqchR4YOOcBqM8qM7ehp3Ke2WhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=d4ZiWotd; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="d4ZiWotd"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d76812f06dso1887305ad.1
        for <audit@vger.kernel.org>; Tue, 23 Jan 2024 14:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706049306; x=1706654106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYX4sxQdBRiQXMechk4fM/KPkjDv5wx/oHtUZ6qdg2o=;
        b=d4ZiWotdPvQYe+OtY4QvR7AA83pdA9ll62k3swUn/nYu07ZN3eRT6hGrFNVxJetkFN
         uMNFLaUwy/9/u/ijzmI81qM9/zr2yRQ3ullIkkXVf1TixNdiwJBQjmNRrwIUdlIzvROh
         VeNpreRYymvCR4Rr6BNFlw3sHaEJMTv7u9zTxWVI1xqo7b0zHh+n7erIN52WELkrEt9E
         7qefJYrHpIjxoJFmgNTqVAIFgmWji5DaaMTDvBZyXQRrpnsZQ9NYcY5Mmt/+TnwJGHeF
         +hxwjKKg+jY18m9ZS/EXqf45M4E87VJBAGlapcTU7a5JwbtixPtvv0yiUrMkN+UJfi0N
         LwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706049306; x=1706654106;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYX4sxQdBRiQXMechk4fM/KPkjDv5wx/oHtUZ6qdg2o=;
        b=rXB+9+oTH0+2mUj3+yJr/ptzVc+Tz7tY87bSC0JnoYuxcJRMLs2GkHhgnchXFRxMWT
         CewMTZ6goYUWzmz9fjAmSWZUo/38bYBDzyuJsuMwcFvntgn0RQu5jKCkf7S7dsBcyaUz
         vik3h7/MNAGyeeNpsLYva1+filO29mFem+TJg31N7QKfxblUWTksK63W5dRQqxIDv6m8
         htesJmkcWrnPRou1nr9fgBB75Aw9vJtSLAV2wnZEOOgaZiZqm382IKN5wjjhESE434G5
         w0On2WdeybDpAM+VLRM0CIMf38io7jhpPjViyDiG/lIY8y1GT8ZsWanZvA4mGOEe8vRE
         zKFA==
X-Gm-Message-State: AOJu0Yzjun/sOlTeRnPKHfSVdGR2Fb9hBH21JSLk9ILWW7lT7ZWU2/Jd
	amh6sZZr+mOGrNtJ7fWwxl4D+2ou8d1SmPSHGxODsMowQh9SoMvJQ3+EUdAv68E=
X-Google-Smtp-Source: AGHT+IGzgKETjph7Kki1PqWl4eR81owodQnV07bpTCP7RHolp+7yblQRXXBclNEKFAJGmHt1mCviDQ==
X-Received: by 2002:a17:902:ed41:b0:1d5:efd6:20f with SMTP id y1-20020a170902ed4100b001d5efd6020fmr12855960plb.1.1706049306021;
        Tue, 23 Jan 2024 14:35:06 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902eb0200b001d756c2f653sm3572750plb.289.2024.01.23.14.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 14:35:05 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, linux-security-module@vger.kernel.org, 
 selinux@vger.kernel.org, audit@vger.kernel.org, 
 Paul Moore <paul@paul-moore.com>
In-Reply-To: <20240123215501.289566-2-paul@paul-moore.com>
References: <20240123215501.289566-2-paul@paul-moore.com>
Subject: Re: [PATCH] io_uring: enable audit and restrict cred override for
 IORING_OP_FIXED_FD_INSTALL
Message-Id: <170604930501.2065523.10114697425588415558.b4-ty@kernel.dk>
Date: Tue, 23 Jan 2024 15:35:05 -0700
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 23 Jan 2024 16:55:02 -0500, Paul Moore wrote:
> We need to correct some aspects of the IORING_OP_FIXED_FD_INSTALL
> command to take into account the security implications of making an
> io_uring-private file descriptor generally accessible to a userspace
> task.
> 
> The first change in this patch is to enable auditing of the FD_INSTALL
> operation as installing a file descriptor into a task's file descriptor
> table is a security relevant operation and something that admins/users
> may want to audit.
> 
> [...]

Applied, thanks!

[1/1] io_uring: enable audit and restrict cred override for IORING_OP_FIXED_FD_INSTALL
      commit: 16bae3e1377846734ec6b87eee459c0f3551692c

Best regards,
-- 
Jens Axboe



