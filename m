Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993191E4A4
	for <audit@vger.kernel.org>; Sun,  5 Jan 2025 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736040232; cv=none; b=Tz1E6ZAaNkraH0BTz8St73nxB15eCkYo+MZrn9TNWeXwqtN9EhKYI1Nng3vfzKqdooG9+DDC86Fy3SR15N59RrLxyP/u+7MZqqlFQDiPJ2CY6t123AVyuEY6eZiZe453jBjc1mFzVwH8zd7QLbMRRGGBuWCzoTHdkHHv3I71DqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736040232; c=relaxed/simple;
	bh=NgbM1kgICYJkniHR12jyNN34V8S31mdefZWKKrJmgP4=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=prt99gfG+rqgS82izuqKMZPrErKQCcaxpMLYPj0gBm62uGP4KJnBoLyvquHdlqSg6qT2smFWBAPAoSi2hrbZr6yJUNKIHx3kp3TaIMWjlwb4CT9A496dsQOroIPNpa/1NsQqf8SnTNpZFCxTK8ws7oPxOpDmNKP1O5lcFUBK/zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q54T68i+; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q54T68i+"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4679eacf25cso72273581cf.3
        for <audit@vger.kernel.org>; Sat, 04 Jan 2025 17:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736040229; x=1736645029; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxMgtgH324ptRSfJuMXT0SPkpytX5VIj9J4ESLVqwIA=;
        b=Q54T68i+BR9hERYTkJkXV7Ddt1XGGNI40LfbijMVzimIIUNDEfKZlLd2j9pekVUBJ+
         pHUtY/yzjfXGLBD8OkFSk+/kcNzBYN3IjUix8lIZxKYEAzF2mxCGSOY6NH8Uvh34Ihvl
         YKjKguf74UkXJ1rNOMcF42Utpmx67WDJYEoQIRbtmarJbU+1zmCShIsVqKzKaj82u/D6
         QCw7VmWi2yuZ9RmrlaT65VKTJk6huztgHkAXZrbZmfl1Scj8ozO2SaRrL9Wzpms3GrhB
         Oc0zpjdqQUMlEZz02PtAMlaGUnrsldMXMzr3dyS1wRuE+cA7Ukn+bqNL3JrahGRPVKoI
         6KsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736040229; x=1736645029;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TxMgtgH324ptRSfJuMXT0SPkpytX5VIj9J4ESLVqwIA=;
        b=cM68KXupY/S7ef7Kg/TIoW5tEEv1AdIoJGgN2r0X7DAatKO0aTighEzl5j8P3uJZKg
         KABkZNxZ83HezwCnEYinz5du48eL5hZ5f3G5KLq8YkVE1PARo3hmN6q9U+MGHokPNCvl
         MD7nEoRNOX0G80q+j0nOXtme7rAhVV+zqEeUiKZkW+DD1aING+x62GW3+SCajL/GVyeX
         Vy3F2Xck+4ghzhS0YfgLgeRdfONvI/Xm51fNz1qlGPdIgXk06BaMIJ5yDIIFhTnzTHkj
         BNzdSm4cHaCV5dX3eWs4gTT3t/DlgKYDJIiPYBC2NK39GNxzKCi0kKDPveS0GCtBDEuX
         t4ww==
X-Forwarded-Encrypted: i=1; AJvYcCUPPIiEFaksW84zh7pBfzbZ1vLUiB82AxCBjgqmBE2aJMyy3Q7/9pxfC9NBWBsiEmFKv0UGaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvHrRgVN57UnyJ6A2FSpwAdWImOOY7YfKGH9xzIT4XdTKFbTut
	a3B3yx4UCUMX7fSJLwGPn1NNPrCRVRnQBz2N7m2rn7TFVgwvavLcdMB/sq3nZw==
X-Gm-Gg: ASbGncsMcAkgcY3GyCcqiLmDEMamMW1Ppp09YI6qSlqKeOKrUWmzSqGbFA3UYXTpkc3
	autvLnDv0qK9Z5Plus2t5ncpewjUIkOTPn8pifxwv3PelnG6HDweNesSCIDlg4MN/OSJsI2qKsO
	MIrfHdq9cfiYO4yuDdPc94f1KR7TQ/KmVBHoMn3KX0PkMPU833sdAIEvAYQEwu4JVJYPoEKh/gp
	DCjF6Pb0fia44qwFd3f/g/Qu//+UBF2aaJpG8I/ORDd3oReTew=
X-Google-Smtp-Source: AGHT+IFdk+ZliRwQLXV7AXBiqpq1OufmuvXYdjN7bKWLAEyGOOimSW/Kxj7uTQosuVb0lCFRfFQeJQ==
X-Received: by 2002:ac8:5dce:0:b0:466:8819:6fa5 with SMTP id d75a77b69052e-46a4a8ccab3mr868889231cf.15.1736040229571;
        Sat, 04 Jan 2025 17:23:49 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a6f8d1609sm127874061cf.64.2025.01.04.17.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 17:23:49 -0800 (PST)
Date: Sat, 04 Jan 2025 20:23:48 -0500
Message-ID: <382de732ebaa88fe89e2c36b9216df57@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250104_1133/pstg-lib:20250104_1133/pstg-pwork:20250104_1133
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Eric Paris <eparis@redhat.com>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/23] lsm: Add audit_log_lsm_data() helper
References: <20241122143353.59367-3-mic@digikod.net>
In-Reply-To: <20241122143353.59367-3-mic@digikod.net>

On Nov 22, 2024 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> Extract code from dump_common_audit_data() into the audit_log_lsm_data()
> helper. This helps reuse common LSM audit data while not abusing
> AUDIT_AVC records because of the common_lsm_audit() helper.
> 
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241122143353.59367-3-mic@digikod.net
> ---
> Changes since v1:
> - Fix commit message (spotted by Paul).
> - Constify dump_common_audit_data()'s and audit_log_lsm_data()'s "a"
>   argument.
> - Fix build without CONFIG_NET: see previous patch.
> ---
>  include/linux/lsm_audit.h |  8 ++++++++
>  security/lsm_audit.c      | 27 ++++++++++++++++++---------
>  2 files changed, 26 insertions(+), 9 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
