Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274742BE7BC
	for <audit@vger.kernel.org>; Wed, 13 Aug 2025 05:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063496; cv=none; b=C5MU0TmhrwkTtBF7dsUIVgDrDcznkoK3E/dvSyavsaQx+jn3JbK3yC7GzUMAP+RRnOQmPTz/jL3miGobhiaiKjdnT84ldeZfDoOeSs87pmGaCUS+cUeOWeXJOuHeC+SROupWSg3KweQs+/jM7RKUXez+Zo9EJ/2mnGoNZVgC3dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063496; c=relaxed/simple;
	bh=fz7vpn3vSH+1er2D1cBKJjGlj43FOUOvtWS0JgPz0aE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sqBvCkDnk7jfQMj96f3bha+24Nmi1Zw0upZtBMK3BdTwvWn2LYdFg4wYaRz3q2yxgK2iqMbx5kgB6IMpRsENA/C6VqeYlgLc7PoGkvJu4USIP+/AR/P7JR88va4ZF2loKXf8CRoe6zoKTj5l7+K1OrLtRYFi4A697zchVJDmBYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EB7ZJSF9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EB7ZJSF9"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-459e3926cbbso26240645e9.1
        for <audit@vger.kernel.org>; Tue, 12 Aug 2025 22:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755063492; x=1755668292; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZtm3WhRjngbfc2XVyDmoZGiMzQGpKQ9/Z/Y44j56eU=;
        b=EB7ZJSF9LGiDssAhP2jSLBJ97II5P0jZ2sJ4jNsj3q5dsvFUiuZD3uUgcJ+4S3JEyS
         Ar+4xAJfmPXiK2WT6QTkJCB6b3DVAlpFjRTdpHjgaFk+V/J+TkHz/J0ueu4BH4PBpl0N
         s2zUELa36hMfIJ2p6pn8/Eru0qtgUmogQ6pjgfJ4ceoPWmS8PVZXIjMVNvEmLAysGZQ6
         rNDoF00LLR4Bgm0s9ADXk9Y3k4B6mUwSrgVgP6nc8X6lemM4X1PxP6yfR4ivzCZWGHR9
         cjFny+PeMKHhphAYuQpMpgrgsKx0BvV8nfihWCIR9cdEH4+WJ4Lx/+nzgz28Jx5lnL3W
         L5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755063492; x=1755668292;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZtm3WhRjngbfc2XVyDmoZGiMzQGpKQ9/Z/Y44j56eU=;
        b=G/6zWVs2Y8VvH58X4D1lHrMPq5MVkUUWba4Km6uM/FzMka+PXaAlypL2QgIPExqpSq
         ooJuyp6mV+uS3iUJ8uY4+XmKJy1JUfMJg6+3rksWMvKDRuJzIof17E0D3coY3fpiwV8a
         6O9EyxVP0UszUF5ZI52P9bY1QukePxUwe6M08mcAJXS6pMADrPHpNY/ITxDmRNmyRKVF
         4VlNt+fKIPd3qH4q7ZauFYlTjYSJ7Cng0nZL/LHb9HTvclyZ6WbeznsjGX3gPRvIDs4o
         7g7THpb4J78KKTKEz3qZj8zMUNxuCUm/V+BzwiB2ozJVABvAJFJq5vCO8sA7JerKjUmR
         wkaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfSWmaWnF3qw4zUuu248xRfEXuRLWrZEb+QUurqAuI5gdxNPzltd1oir4gP/8QqZi+LtGWTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoOiUcwW9A1lrubyvn4UxqK0z8DdrNlVXW0fv2bQ9bQjWySf2N
	WkTf+Um5D1z8ITOYr1tujU02E1Z39wofpwSp9uQ43YBem75yEwouJumNa9gwe4fRRAU=
X-Gm-Gg: ASbGnctCfeJhM160W3H6yQy0X9y5CMPMvsiaq3Y0f7MCf2J3PHmDW7s4EKkrz9MVMEw
	WzUJACKzpzCYVW2/xXcAo6XYdLxN5l8ViYZV4Jdk/HV+80xi9JshRtrtN246+lEOdy6/yS2A5xi
	DJ/C9XSEh/7kgLGk7RhkMnn06LhBp/AUgM60jwY35u50q/dlw4/l4TLIn17DIUD1I9HN4VCNmID
	GpTPHcmaEx/wvQEm2MCtH+PMW0IoQqoqlHMxEOSfINMeTcnqtOYp0PNyaf6w07EB1Q4TIN04qQQ
	EncsT84i9A21V7tnu1Ig5FRlGxAHIgrwcxe4dX8s4oVHvZakWunljzP1ig1shS02FpyTt1uNolW
	ae6tDw33wlA9opR4Va2jitojTwSI=
X-Google-Smtp-Source: AGHT+IH+A9B65CILVNd8g+8r1zIX9u7ub4DQznDepgDLM6ZOnlHu2xwuwZKKdRqHmlx+u58rKL4KAQ==
X-Received: by 2002:a05:600c:45cc:b0:458:f70d:ebdd with SMTP id 5b1f17b1804b1-45a165dc8dcmr13438905e9.16.1755063492511;
        Tue, 12 Aug 2025 22:38:12 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a16def069sm14136905e9.20.2025.08.12.22.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 22:38:12 -0700 (PDT)
Date: Wed, 13 Aug 2025 08:38:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	audit@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] audit: add a missing tab
Message-ID: <aJwkwMRSxUAvI4dF@stanley.mountain>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Someone got a bit carried away deleting tabs.  Add it back.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 kernel/auditsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 1c29541c8fb6..497bda0043fb 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1778,7 +1778,7 @@ static void audit_log_exit(void)
 						  axs->target_sessionid[i],
 						  &axs->target_ref[i],
 						  axs->target_comm[i]))
-			call_panic = 1;
+				call_panic = 1;
 	}
 
 	if (context->target_pid &&
-- 
2.47.2

