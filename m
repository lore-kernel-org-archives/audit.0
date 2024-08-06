Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA8F170A21
	for <audit@vger.kernel.org>; Tue,  6 Aug 2024 20:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977974; cv=none; b=onwosuVVq1+1HuBnH6k3W9tSvJ2BBMnIirVqDb5ZeHgSJnJMfMECNdVaqNk4CiWtAIqK47wEeYl0tlKa04ommzDu1bm2NzMlCvu+t80XX/Wa1uuOlKO0gHPj0Au0R8+QS9VXilUVMg1j4gtySbq2gT4t7UF3okWX2c0yoE2FX1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977974; c=relaxed/simple;
	bh=qyUz9Qqv5k5SudOvCxQPX4RBki5RQXyIqfhgrvWKdyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjSUaT/CRBqs1986reTQIKiJs7ukoVRmnNAvCl6skQ3PLNFllXX+lj+thvHjYzTUuOgTqK7s1+u9/uJvKPefdUdRGCL89uK2dp2wpr8aD/ljpttaQ8Vk4Gctuu6D/AyGNOWLV/fPPNql61U71yEXGc/v9xFzKKsvzosl3lGozJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Eb3sUuf/; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Eb3sUuf/"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso1096880276.0
        for <audit@vger.kernel.org>; Tue, 06 Aug 2024 13:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722977971; x=1723582771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqRA/CX/CVDKRMnMKUkE7btXGpws1I/eaVA/YpB62Hc=;
        b=Eb3sUuf/v0kca+XnoKJZRiENpb45DUPlfGi6IMf13qoSoLYimi3mbIv6qhH8hOEh8A
         mtVov7Lo2+nWdrAHGka9zLYVA1Sjmjb3AcjWwDADP1msPFly37oB04+MJAo54CujViTu
         a1vCj3WAE+S3ZIjyJgFSjCbqF+44/OIo599KJgBo80TX+cbW1YJaofC74vUrXxBHwvc3
         sFE1L/cMDbIe99kU4N5IUeNp9/6xTDjzSbnrqVs0378SkaDdfLa0lvtM6stQdlKdcDlN
         DrmYuETjc7TuhIltjqm90BxNzaWLUuccUumCJk4/JR+ilZrg3hf3VdnUc5ty8V2xUoWk
         yVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722977971; x=1723582771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqRA/CX/CVDKRMnMKUkE7btXGpws1I/eaVA/YpB62Hc=;
        b=RDiI0cpzx3ygy2N31W2rSE898JLAFqax6HSfGH41AE0UdPsgrdLn1octcylKjBuHO7
         XfBZm1D7GNSAEPoO1xcntct57wHbf32NqdVaWM/QEB3gXUTGLpuGYtaE6VsIkRnyASJH
         DMopcZE6lmTpRWgP49L/WvYfEYfnIxDndkLwEe/SITtxTnPdtSAgego+S0adcMaG+QY+
         UCAC1//3ky4h+GOWlyVLrHxZ8Up+qjwVGmTL/mzmttvaFWfHUD81giuMy4ztXFeeQz/M
         dUsJFcYRpNzpQ/SylYae3F8j1iZdIA+S4Eu9Jjfppzf/Ld9eSJ0SbXEwpFza+gaDIzZ+
         pNbA==
X-Forwarded-Encrypted: i=1; AJvYcCU2RfjHQZbTNqAalpq2kGbFUnhfyj48FzSXoIqssTT/LtwWT+8/+uNFmkG0yvt9joqGU8FxXVWDJNuaSr0CESZkI4QoHPM=
X-Gm-Message-State: AOJu0Yxqov5wexf36v75k542fma9EZ5X7l1IGkFU+Rgo7bju8LWdNIo2
	WWYVVFBCJJT4c71S/FxpK+/vCnEIOkxByYJ1Hy7SIxvw3/D3f/08hF/oA73zysBhNjKTH8Ij2X6
	X8KnZ7C02Z2cIyBz7V+yzaBrAInXFTJwB92Bj
X-Google-Smtp-Source: AGHT+IG+g9ZPIj3c+gMV8h9nbV6S0gFWlT866BH5MDCEFMia55H31Vc+W1m/exuwqdaE7fTnf6/iUgbwZyFG5W1FJkM=
X-Received: by 2002:a05:6902:15c5:b0:e0b:e2ed:b6c9 with SMTP id
 3f1490d57ef6-e0be2edba28mr17255194276.9.1722977971481; Tue, 06 Aug 2024
 13:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 6 Aug 2024 16:59:20 -0400
Message-ID: <CAHC9VhQ3LobZks+JtcmOxiDH1_kbjXq3ao8th4V_VXO8VAh6YA@mail.gmail.com>
Subject: Re: [PATCH v20 00/20] Integrity Policy Enforcement LSM (IPE)
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, 
	tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, 
	snitzer@kernel.org, mpatocka@redhat.com, eparis@redhat.com, 
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 2:08=E2=80=AFAM Fan Wu <wufan@linux.microsoft.com> w=
rote:
>
> IPE is a Linux Security Module that takes a complementary approach to
> access control. Unlike traditional access control mechanisms that rely on
> labels and paths for decision-making, IPE focuses on the immutable securi=
ty
> properties inherent to system components. These properties are fundamenta=
l
> attributes or features of a system component that cannot be altered,
> ensuring a consistent and reliable basis for security decisions.
>
> ...

There was some minor merge fuzz, a handful of overly long lines in the
comments, and some subject lines that needed some minor tweaking but
overall I think this looks good.  I only see one thing holding me back
from merging this into the LSM tree: an updated ACK from the
device-mapper folks; if we can get that within the next week or two
that would be great.

--=20
paul-moore.com
