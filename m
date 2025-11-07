Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077431D61BC
	for <audit@vger.kernel.org>; Fri,  7 Nov 2025 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762552244; cv=none; b=e1Hgtb6J9vmcmGe6gJ7Svj+HO4PGQO+te3OI0bzvEOKS9/ECC+nyv0jX8S9FXyHoUUUww0moprkwmFk8xqiyAL00gozG8i85/a1Nz6KPmNMRgKqma/WjZ67eZU1sacORSqo4tunshpSzI5j/hy53dUMWXG4zpmkfeakTMsmvNmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762552244; c=relaxed/simple;
	bh=pyLdhXK+e9aYqC0P31ccDopOnZF1MrhAcR9qbpwJoj8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=t67bW7XgAth/cbH3LF0lzf28wTZyJF3vkPR4M5k2VZnFsBRdkgb5egMAUNuIjwitR3AwNiUNnrW5dmbTBlvVjelq+qMzP/0dOfFe7zhsQM56nnbtjId/AF5aZI1RQbBhEToyGP9e8LQ5ysDhdRsiMh9oX2ySGF9qBjpbF/hnDaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Yzr0+uWX; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Yzr0+uWX"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4e8850b09eeso9521011cf.0
        for <audit@vger.kernel.org>; Fri, 07 Nov 2025 13:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762552242; x=1763157042; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QmoTkq/M8jICHPZ59r+DbNONIA6SHcI9Tq5Z/TFZHS4=;
        b=Yzr0+uWX9y8maaLAoumVIlQ25OBsnB6rkY/07veYawgHwfnBFux7WAkVFXqQennQ8t
         w3sGSjwqvEv7AMdWRYk8VVWWuwzvhBtJejwn21Wp67ceb8pIG4lnU+PYHquk2iD8R+ou
         9gQm4jc2X/r1RURMm9Vp/q/YBD/1T8uZVedTZuG2VL3c5EdGUVoGYaoCpgGoAJVxvm1M
         iIEzKd296L9G/7/I/7Eb+9hHXA+LhrVAYVdgHKEQVxeONpEgnUurxngk2XJbZFXRUilM
         /ZCcHuFNKTIgvZGttUsCMk9zc+L/ZvMkPLRRfirZNxQebFHnTGi0ffmUBhua1E9pkkRN
         6Jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762552242; x=1763157042;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmoTkq/M8jICHPZ59r+DbNONIA6SHcI9Tq5Z/TFZHS4=;
        b=c8aOp1UwBN8ppEiH31KOBwNCg+gz51TETT56L72No7c8S1QpRIiIYyoadmo3a4S2TD
         dZvdskVVLLXUItG0m4fE/xVR1G5B79zk8LNRqQ8bF4iDnfoiDkaN/2FuD1EupExK7l19
         mCnDymG6nbIG0V3eDAu29/THpX1RPuap0SDZCDCeRldUdEtST5Vd4wAt4vQJsASYMHj4
         UWSNRPGvsv8y6ojLAe1cAB74mkjSS4o9xVZhdFkYiaI3AC6Rc+r7qtAfkzQOheEgwl0w
         r30ySLI+VHGUzSMmQCoaxLrBF8fz+wjSx1NAlL3r4xCE3aJDV9kH/lAx7nhRATv/wauN
         QnQg==
X-Forwarded-Encrypted: i=1; AJvYcCX77yq9MOBsuajNNmO/R4z1b0vab1mvjQ9SBuS79Y0zEzVrPovNabMcrQqQ1zp/xDhK/FmYRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxX+w/jfqJoYVfDBdLS/Wm2mFOiTPGdWGirzkrWU0Un3ay64uID
	Vukj+lNsbcev0g5tCiDkl4g+1bM966kbNOTtcmpwSv+B/bqUDkvM3iYnalM2/J61pg==
X-Gm-Gg: ASbGncvvDYm4cEw7iKAwrOvQjbHzTE5lGOTe+3QSXvB9fnDbTAp/YQCzSL0ruzdJRvA
	QxHu8zei97+sS6HPYSV3Am7ol7lYOGK3uI4Rgu7y3MWbVy6t596FfR7ByJpE496ItViW3cRMdUN
	R2KuqI227Y+9qW/LpJOe27J4Z+3JAX8sBJIkKe+buVEXeF3Jgx82Ss45SQoysMmaNf3UMMCC9Nn
	v97Gzyi9KOsxjiX8NDSsViwtbxvmIFRGE1IV6Wz8Io1kfLLLEEM7P/p1I5GWiDHSuvsV1/U+uIB
	KPI+4WK9HVUMEAlMHMai/MavGWJkuwE2nM4zxYpwiY+E95uB4yVABAuioXB3OcRbBXVAXb3kHia
	UR8Rt7k9L0cDb45V7zsb5TJVQq5eCvWZpxCoGWGMLfxEXiCavImfjgKbss6rEqeRTxo1kQDKTy6
	SL3yuadHg+n1/+ItTFBlHhCiyDBvBLyQrH+7sBWSTFDugL0PAJwTkO3UPS
X-Google-Smtp-Source: AGHT+IGBsd98wCcuB1QNhGT9aKSRlEdnLcFa0mRVXHbfEi8hgtEWG9e4T8/HI0hMNHHgXfKIqunFKg==
X-Received: by 2002:ac8:5a0f:0:b0:4ec:eec7:4850 with SMTP id d75a77b69052e-4eda4f7ec78mr7855511cf.44.1762552242055;
        Fri, 07 Nov 2025 13:50:42 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8823896818asm3361046d6.14.2025.11.07.13.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:50:41 -0800 (PST)
Date: Fri, 07 Nov 2025 16:50:40 -0500
Message-ID: <54043277138c6499c0ced9bbdcae7cf5@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251107_1632/pstg-lib:20251106_1733/pstg-pwork:20251107_1632
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v3] audit: merge loops in __audit_inode_child()
References: <20251031123328.1758743-1-rrobaina@redhat.com>
In-Reply-To: <20251031123328.1758743-1-rrobaina@redhat.com>

On Oct 31, 2025 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> Whenever there's audit context, __audit_inode_child() gets called
> numerous times, which can lead to high latency in scenarios that
> create too many sysfs/debugfs entries at once, for instance, upon
> device_add_disk() invocation.
> 
>    # uname -r
>    6.18.0-rc2+
> 
>    # auditctl -a always,exit -F path=/tmp -k foo
>    # time insmod loop max_loop=1000
>    real 0m46.676s
>    user 0m0.000s
>    sys 0m46.405s
> 
>    # perf record -a insmod loop max_loop=1000
>    # perf report --stdio |grep __audit_inode_child
>    32.73%  insmod [kernel.kallsyms] [k] __audit_inode_child
> 
> __audit_inode_child() searches for both the parent and the child
> in two different loops that iterate over the same list. This
> process can be optimized by merging these into a single loop,
> without changing the function behavior or affecting the code's
> readability.
> 
> This patch merges the two loops that walk through the list
> context->names_list into a single loop. This optimization resulted
> in around 51% performance enhancement for the benchmark.
> 
>    # uname -r
>    6.18.0-rc2-enhancedv3+
> 
>    # auditctl -a always,exit -F path=/tmp -k foo
>    # time insmod loop max_loop=1000
>    real 0m22.899s
>    user 0m0.001s
>    sys 0m22.652s
> 
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  kernel/auditsc.c | 43 +++++++++++++++++++------------------------
>  1 file changed, 19 insertions(+), 24 deletions(-)

Looks good to me, merged into audit/dev, thanks!

--
paul-moore.com
